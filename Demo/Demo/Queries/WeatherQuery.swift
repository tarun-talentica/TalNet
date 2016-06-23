//
//  GetQuery.swift
//  Pod-In-Playground
//
//  Created by Tarun Sharma on 09/05/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation
import TalNet

struct WeatherQuery:GetQueriable {
    
    let path = "/tristanhimmelman/AlamofireObjectMapper/d8bb95982be8a11a2308e779bb9a9707ebe42ede/sample_json"
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