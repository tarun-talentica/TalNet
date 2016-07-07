//
//  SecureNetworkService.swift
//  GSignIn
//
//  Created by Tarun Sharma on 07/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import Foundation

public protocol SecureNetworkService: NetworkService {}

public extension SecureNetworkService {
    
    /// Use https scheme as default for secure network service
    public var scheme: String {
        return "https"
    }
}
