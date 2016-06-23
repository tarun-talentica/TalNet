//
//  Error.swift
//  Pod-In-Playground
//
//  Created by Tarun Sharma on 20/05/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation

public enum Error {
    
    case InvalidAccessToken
    case NoVendorRegistered
    case NoResponseSerializer
    case NoResponseSerializeImplementationByVendor
    case CouldNotConvertVendorResponse
    case StringSerializationFailed
    case JSONSerializationFailed
    case Other(NSError)
    
    /// The domain used for creating all Alamofire errors.
    public static let ErrorDomain = "com.Talentica.error"
    
    public enum ErrorCode:Int {
        case InvalidAccessToken = -9000
        case NoVendorRegistered = -9001
        case NoResponseSerializer = -9002
        case NoResponseSerializeImplementationByVendor = -9003
        case CouldNotConvertVendorResponse = -9004
        case StringSerializationFailed = -9005
        case JSONSerializationFailed = -9006
    }
    
    public enum Reason:String {
        case InvalidAccessToken = "Invalid Access Token"
        case NoVendorRegistered = "No Vendor Found"
        case NoResponseSerializer = "No Response Serializer Found"
        case NoResponseSerializeImplementationByVendor = "Vendor specified this response is serializable, but did not provide any implementation"
        case CouldNotConvertVendorResponse = "Could not convert vendor response to desired type"
        case StringSerializationFailed = "String could not be serialized. Input data was nil."
        case JSONSerializationFailed = "JSON could not be serialized."
    }
    
    /**
     Creates an `NSError` with the given error code and failure reason.
     
     - parameter code:          The error code.
     - parameter failureReason: The failure reason.
     
     - returns: An `NSError` with the given error code and failure reason.
     */
    public static func errorWithCode(code: Int, failureReason: String) -> NSError {
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        return NSError(domain: ErrorDomain, code: code, userInfo: userInfo)
    }
    
    // Used to convert Error to NSError
    var nsError: NSError {
        switch self {
        case .InvalidAccessToken:
            return Error.errorWithCode(ErrorCode.InvalidAccessToken.rawValue,failureReason: Reason.InvalidAccessToken.rawValue)
        case .NoVendorRegistered:
            return Error.errorWithCode(ErrorCode.NoVendorRegistered.rawValue,failureReason: Reason.NoVendorRegistered.rawValue)
        case .NoResponseSerializer:
            return Error.errorWithCode(ErrorCode.NoResponseSerializer.rawValue,failureReason: Reason.NoResponseSerializer.rawValue)
        case .CouldNotConvertVendorResponse:
            return Error.errorWithCode(ErrorCode.CouldNotConvertVendorResponse.rawValue,failureReason: Reason.CouldNotConvertVendorResponse.rawValue)
        case .NoResponseSerializeImplementationByVendor:
            return Error.errorWithCode(ErrorCode.NoResponseSerializeImplementationByVendor.rawValue,failureReason: Reason.NoResponseSerializeImplementationByVendor.rawValue)
        case .StringSerializationFailed:
            return Error.errorWithCode(ErrorCode.StringSerializationFailed.rawValue,failureReason: Reason.StringSerializationFailed.rawValue)
        case .JSONSerializationFailed:
            return Error.errorWithCode(ErrorCode.JSONSerializationFailed.rawValue,failureReason: Reason.JSONSerializationFailed.rawValue)
        case .Other(let error):
            return NSError(domain: Error.ErrorDomain, code: error.code, userInfo: error.userInfo)
        }
    }

}