//
//  VCLDeepLinkMocks.swift
//  VCLTests
//
//  Created by Michael Avoyan on 16/08/2021.
//

import Foundation
@testable import VCL

class DeepLinkMocks {
    static let PresentationRequestDeepLinkStr = "velocity-network://inspect?request_uri=https%3A%2F%2Fvelocityapidev.cisive.com%2Fapi%2Fholder%2Fv0.6%2Forg%2Fdid%3Aion%3AEiCX1aArW9hcDENE4VYnUz-yKWOsNnlPGSWZfIzU4ZllVA%2Finspect%2Fget-presentation-request%3Fid%3D61f03bccdfef8e3537add745&inspectorDid=did%3Aion%3AEiCX1aArW9hcDENE4VYnUz-yKWOsNnlPGSWZfIzU4ZllVA&vendorOriginContext=%7B%22SubjectKey%22%3A%7B%22BusinessUnit%22%3A%22ZC%22,%22KeyCode%22%3A%2254514480%22%7D,%22Token%22%3A%22832077a4%22%7D"
    
    static let PresentationRequestDeepLink = VCLDeepLink(value: PresentationRequestDeepLinkStr)
    
    static let PresentationRequestRequestUriStr = "https://velocityapidev.cisive.com/api/holder/v0.6/org/did:ion:EiCX1aArW9hcDENE4VYnUz-yKWOsNnlPGSWZfIzU4ZllVA/inspect/get-presentation-request?id=61f03bccdfef8e3537add745&inspectorDid=did%3Aion%3AEiCX1aArW9hcDENE4VYnUz-yKWOsNnlPGSWZfIzU4ZllVA&vendorOriginContext=%7B%22SubjectKey%22%3A%7B%22BusinessUnit%22%3A%22ZC%22,%22KeyCode%22%3A%2254514480%22%7D,%22Token%22%3A%22832077a4%22%7D"

    static let PresentationRequestVendorOriginContext = "{\"SubjectKey\":{\"BusinessUnit\":\"ZC\",\"KeyCode\":\"54514480\"},\"Token\":\"832077a4\"}"

    static let CredentialManifestDeepLinkStr =
        "velocity-network://issue?request_uri=https%3A%2F%2Fdevagent.velocitycareerlabs.io%2Fapi%2Fholder%2Fv0.6%2Forg%2Fdid%3Avelocity%3A0xd4df29726d500f9b85bc6c7f1b3c021f16305692%2Fissue%2Fget-credential-manifest%3Fid%3D611b5836e93d08000af6f1bc%26credential_types%3DPastEmploymentPosition"
    
    static let CredentialManifestDeepLink = VCLDeepLink(value: CredentialManifestDeepLinkStr)
    
    static let CredentialManifestRequestUriStr = "https://devagent.velocitycareerlabs.io/api/holder/v0.6/org/did:velocity:0xd4df29726d500f9b85bc6c7f1b3c021f16305692/issue/get-credential-manifest?id=611b5836e93d08000af6f1bc&credential_types=PastEmploymentPosition"

}
