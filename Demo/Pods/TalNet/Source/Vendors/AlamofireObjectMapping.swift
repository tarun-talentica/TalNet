//
//  AlamofireObjectMapping.swift
//  Pod-In-Playground
//
//  Created by Tarun Sharma on 13/05/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

public typealias ObjectMap = ObjectMapper.Map


public protocol ObjectMappable:Mappable {
    init?(_ mapper:ObjectMap)
    mutating func mapObject(from mapper:ObjectMap)
}

public extension ObjectMappable {
    init?(_ map: ObjectMap){
        self.init(map)
    }
    
    mutating func mapping(map: Map) {
        self.mapObject(from: map)
    }
}

public extension ObjectSerializable {
    func serialize(from request:CancellableRequest,completionHandler: QueryResponse<ObjectType,NSError> -> Void) {
        
        request.innerCancellable?.vendorRequest?.responseObject {
            (response:VendorResponse<ObjectType,NSError>) in
            completionHandler(convertResponseToQueryResult(response))
        }
    }
}

public extension ObjectArraySerializable {
  func serialize(from request:CancellableRequest,completionHandler: QueryResponse<[ObjectType], NSError> -> Void) {
    
    request.innerCancellable?.vendorRequest?.responseArray(keyPath: self.keyPath) {
      (response: VendorResponse<[ObjectType],NSError>) in
      completionHandler(convertResponseToQueryResult(response))
    }
  }
}
