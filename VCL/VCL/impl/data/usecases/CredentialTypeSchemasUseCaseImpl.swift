//
//  CredentialTypeSchemasUseCaseImpl.swift
//  VCL
//
//  Created by Michael Avoyan on 22/03/2021.
//

import Foundation

class CredentialTypeSchemasUseCaseImpl: CredentialTypeSchemasUseCase {
    
    private let credentialTypeSchemasRepository: CredentialTypeSchemaRepository
    private let credenctiialTypes: VCLCredentialTypes
    private let executor: Executor
    private let dispatcher: Dispatcher
    
    private let concurrentCredentialTypeSchemasQueue =
      DispatchQueue(
        label: "\(GlobalConfig.VclPackage).CredentialTypeSchemasMap",
        attributes: .concurrent)
        
    init(_ credentialTypeSchemasRepository: CredentialTypeSchemaRepository,
         _ credenctiialTypes: VCLCredentialTypes,
         _ executor: Executor,
         _ dispatcher: Dispatcher) {
        self.credentialTypeSchemasRepository = credentialTypeSchemasRepository
        self.credenctiialTypes = credenctiialTypes
        self.executor = executor
        self.dispatcher = dispatcher
    }
    
    func getCredentialTypeSchemas(completionBlock: @escaping (VCLResult<VCLCredentialTypeSchemas>) -> Void) {
        var credentialTypeSchemasMap = [String: VCLCredentialTypeSchema]()
        var credentialTypeSchemasMapIsEmpty = true
        
        executor.runOnBackgroundThread { [weak self] in
            let schemaNamesArr =
                self?.credenctiialTypes.all?.filter { $0.schemaName != nil }.map { $0.schemaName! } ?? Array()
            
            schemaNamesArr.forEach { schemaName in
                self?.dispatcher.enter()
                self?.credentialTypeSchemasRepository.getCredentialTypeSchema(
                    schemaName: schemaName,
                    completionBlock: { result in
                        do {
                            let credentialTypeSchema = try result.get()
                            self?.concurrentCredentialTypeSchemasQueue.async(flags: .barrier) {
                                credentialTypeSchemasMap.updateValue(credentialTypeSchema, forKey: schemaName)
                                credentialTypeSchemasMapIsEmpty = credentialTypeSchemasMap.isEmpty
                            }
                        } catch {
                            // no need to handle
                        }
                        self?.dispatcher.leave()
                    }
                )
            }
            self?.dispatcher.notify(queue: .main) {
                if(credentialTypeSchemasMapIsEmpty) {
                    completionBlock(.failure(VCLError(description: "Failed to fetch credential type schemas")))
                } else {
                    completionBlock(.success(VCLCredentialTypeSchemas(all: credentialTypeSchemasMap)))
                }
            }
        }
    }
}
