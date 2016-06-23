//
//  ForcastQuery.swift
//  Pod-In-Playground
//
//  Created by Tarun Sharma on 27/05/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation
import TalNet

struct ForcastQuery:GetQueriable {
    
    let path = "/tristanhimmelman/AlamofireObjectMapper/f583be1121dbc5e9b0381b3017718a70c31054f7/sample_array_json"
    
    let service: SecureNetworkService = GithubUserContentService()
    
    var parameters: Parameters? = nil
    var encoding: Encoding = .URL
    
    init () {}
    
    // MARK: Initializers
    init(fooValue: String) {
        parameters = Parameters()
        foo = fooValue
    }
    
    var foo: String {
        get { return parameters?["foo"] as! String }
        set { parameters?["foo"] = newValue }
    }
}