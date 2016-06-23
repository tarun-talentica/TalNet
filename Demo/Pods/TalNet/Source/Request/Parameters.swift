//
//  Parameters.swift
//  GSignIn
//
//  Created by Tarun Sharma on 07/05/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import Foundation

protocol URLQueryItemStringConvertible {
    var stringValue: String { get }
}

//public enum Encoding {
//    case URL,JSON
//}

public struct Parameters {
    
    // This should be optional
    public var parameterDictionary = [String: AnyObject]()
    
    public init() {}
  
    /**
     Subscript for accessing/setting each parameter for key
     - parameter key: String key for accessing parameter value
     - returns: AnyObject that can be kept in [String: AnyObject]
     */
    public subscript(key: String) -> AnyObject? {
        get { return parameterDictionary[key] }
        set(value) { parameterDictionary[key] = value }
    }

}