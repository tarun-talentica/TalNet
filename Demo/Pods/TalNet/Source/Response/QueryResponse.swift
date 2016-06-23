//
//  Response.swift
//  Pod-In-Playground
//
//  Created by Tarun Sharma on 12/05/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation

public struct QueryResponse<Value,Error:ErrorType> {
    
    /// The URL request sent to the server.
    public let request: NSURLRequest?
    
    /// The server's response to the URL request.
    public let response: NSHTTPURLResponse?
    
    /// HttpResponse status code
    public let statusCode:Int?
    
    /// The result of response serialization.
    public let result: QueryResult<Value, Error>
    
    public init(request: NSURLRequest? = nil,
         response: NSHTTPURLResponse? = nil,
         statusCode:Int? = nil,
         result:QueryResult<Value, Error>) {
        self.request = request
        self.response = response
        self.statusCode = statusCode
        self.result = result
    }
}

// MARK: - CustomDebugStringConvertible
extension QueryResponse: CustomDebugStringConvertible {
    /// The debug textual representation used when written to an output stream, which includes the URL request, the URL
    /// response, the server data and the response serialization result.
    public var debugDescription: String {
        var output: [String] = []
        
        output.append(request != nil ? "[Request]: \(request!)" : "[Request]: NIL")
        output.append(response != nil ? "[Response]: \(response!)" : "[Response]: NIL")
        output.append(statusCode != nil ? "[Status Code]: \(statusCode)" : "[Status Code]: NIL")
        output.append("[Result]: \(result.debugDescription)")
        
        return output.joinWithSeparator("\n")
    }
}

public struct StringResponse: StringSerializable {
  public var encoding: NSStringEncoding?
  public init(encoding: NSStringEncoding? = nil) {
    self.encoding = encoding
  }
}

public struct JSONResponse: JsonSerializable {
  public var jsonOptions: NSJSONReadingOptions
  public init(jsonOptions: NSJSONReadingOptions = .AllowFragments) {
    self.jsonOptions = jsonOptions
  }
}

public struct ObjectResponse<T:ObjectMappable>: ObjectSerializable {
    public typealias ObjectType = T
    public init() {}
}

public struct ObjectArrayResponse<T:ObjectMappable>: ObjectArraySerializable {
  public typealias ObjectType = T
  public var keyPath: String?
  public init(keyPath:String? = nil) {
    self.keyPath = keyPath
  }
}
