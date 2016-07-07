//
//  QueriableTests.swift
//  TalNet
//
//  Created by Tarun Sharma on 27/06/16.
//  Copyright © 2016 Talentica. All rights reserved.
//

import XCTest
@testable import TalNet

struct MockGetQuery: GetQueriable {
  var path: String {
    return "/get"
  }
  
  // This builds the URLString from Scheme + Host
  var service: NetworkService = MockNetworkService()
}

struct MockPostQuery: PostQueriable {
  var path: String {
    return "/post"
  }
  
  // This builds the URLString from Scheme + Host
  var service: NetworkService = MockNetworkService()
}

class DefaultQueriableTests: XCTestCase {
  
  func testThatGetQueryDefaultValuesAreSetCorrectly() {
    let mockQuery = MockGetQuery()
    
    XCTAssert(mockQuery.method == .GET)
    XCTAssert(mockQuery.path == "/get")
    XCTAssert(mockQuery.encoding == .URL)
    XCTAssertNil(mockQuery.headers)
    XCTAssertNil(mockQuery.parameters)
  }
  
  func testThatPostQueryDefaultValuesAreSetCorrectly() {
    let mockQuery = MockPostQuery()
    
    XCTAssert(mockQuery.method == .POST)
    XCTAssert(mockQuery.path == "/post")
    XCTAssert(mockQuery.encoding == .URL)
    XCTAssertNil(mockQuery.headers)
    XCTAssertNil(mockQuery.parameters)
  }
}