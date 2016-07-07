//
//  RequestableTests.swift
//  TalNet
//
//  Created by Tarun Sharma on 27/06/16.
//  Copyright © 2016 Talentica. All rights reserved.
//

import XCTest
@testable import TalNet

class MockParamertizedQuery: Queriable {
  var path: String {
    return "/get"
  }
  
  var method: TalNet.Method {
    return .GET
  }
  
  var parameters: Parameters? = nil
  var headers: [String : String]? = nil
  
  // This builds the URLString from Scheme + Host
  var service: NetworkService = MockNetworkService()
  
  init() {}
  
  init(foo:AnyObject) {
    parameters = Parameters(parametrs: ["foo":foo])
  }
}

class MockRequestable: Requestable {
  var query: Queriable
  
  init(_ query: Queriable) {
    self.query = query
  }
}

class MockCustomURLRequestable: Requestable {
  
  var query: Queriable
  
  init(_ query: Queriable) {
    self.query = query
  }
  
  var URLRequest: NSMutableURLRequest {
    return NSMutableURLRequest()
  }
}

class RequestableTests: XCTestCase {

  var mockRequest: Requestable!
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      mockRequest = MockRequestable(MockParamertizedQuery())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

  func testCustomURLRequestProvidingRequestable() {
    mockRequest = MockCustomURLRequestable(MockParamertizedQuery())
    let mutableRequest = mockRequest.URLRequest
    XCTAssertEqual(mutableRequest, NSMutableURLRequest())
  }
  
  func testRequestableDefaultURLMethodWithoutParametersAndHeaders() {
    let mutableRequest = mockRequest.URLRequest
    XCTAssert(mutableRequest.URLString == "http://httpbin.org/get")
    XCTAssertEqual(mutableRequest.HTTPMethod, mockRequest.query.method.rawValue, "Mutable request's http method should be equal to query's method")
  }
  
  func testRequestableDefaultURLMethodWithStringParamters() {
    mockRequest = MockRequestable(MockParamertizedQuery(foo: "bar"))
    let mutableRequest = mockRequest.URLRequest
    XCTAssert(mutableRequest.URL?.query == "foo=bar")
  }
  
  func testRequestableDefaultURLMethodWithArrayParamters() {
    
    /// Given
    let params = ["bar","closed"]
    let mockRequestable = mockRequest as! MockRequestable
    let query = mockRequestable.query as! MockParamertizedQuery
    
    /// When 
    query.parameters = Parameters(parametrs: ["foo": params])
    let mutableRequest = mockRequestable.URLRequest
    
    /// Then
    XCTAssert(mutableRequest.URL?.query == "foo%5B%5D=bar&foo%5B%5D=closed")
  }
  
  func testRequestableDefaultURLMethodWithHeaders() {
    
    /// Given
    let headers = ["Content-Type" : "application/json"]
    let mockRequestable = mockRequest as! MockRequestable
    let query = mockRequestable.query as! MockParamertizedQuery
    query.headers = headers
    
    /// When
    let mutableRequest = mockRequestable.URLRequest
    
    /// Then
    XCTAssertEqual(mutableRequest.valueForHTTPHeaderField("Content-Type") ?? "", "application/json", "Mutable request's header should be equal to query's header")
  }
  
  func testThatAuthorizedRequestableURLRequestMethodSetsAuthorizationHeader() {
    class MockAuthorizedNetworkService: NetworkService {
      var host: String {
        return "httpbin.org"
      }
      
      var scheme: String {
        return "http"
      }
      
      private func authorizeRequest(request: NSMutableURLRequest) -> NSMutableURLRequest {
        request.setValue("Bearer " + "User", forHTTPHeaderField: "Authorization")
        return request
      }
    }
    
    /// Given
    let mockRequestable = mockRequest as! MockRequestable
    let query = mockRequestable.query as! MockParamertizedQuery
    
    /// When
    query.service = MockAuthorizedNetworkService()
    let mutableRequest = mockRequestable.URLRequest
    
    /// Then
    XCTAssertEqual(mutableRequest.valueForHTTPHeaderField("Authorization") ?? "", "Bearer User","Mutable request's header should be equal to query's header")
  }

}
