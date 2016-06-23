//
//  ZenQuery.swift
//  TLCNetworking_Protocol
//
//  Created by Tarun Sharma on 06/06/16.
//  Copyright © 2016 Talentica. All rights reserved.
//

import Foundation
import TalNet

struct ZenQuery:GetQueriable,TokenRefreshingQueriable {
    
    let path = "/zen"
    var parameters: Parameters? = nil
    let service: SecureNetworkService = GitHubAPIService()
    
    // MARK: Initializers
    
    init () {}
        
    init(fooValue: String) {
        parameters = Parameters()
        foo = fooValue
    }
    
    var foo: String {
        get { return parameters?["foo"] as! String }
        set { parameters?["foo"] = newValue }
    }
}