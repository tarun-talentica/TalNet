//
//  DefaultNetworkServiceTests.swift
//  TalNet
//
//  Created by Tarun Sharma on 27/06/16.
//  Copyright © 2016 Talentica. All rights reserved.
//

import XCTest
@testable import TalNet

struct MockNetworkService: NetworkService {
  var host: String {
    return "httpbin.org"
  }
  
  var scheme: String {
    return "http"
  }
}

struct MockSecureNetworkService: SecureNetworkService {
  var host: String {
    return "httpbin.org"
  }
}


class DefaultNetworkServiceTests: XCTestCase {
    func testThatNetworkServiceDefaultValuesAreCorrect() {
      let mockService = MockNetworkService()
      
      XCTAssert(mockService.host == "httpbin.org")
      XCTAssert(mockService.scheme == "http")
      XCTAssertNil(mockService.port)
    }
  
  func testThatSecureNetworkServiceDefaultValuesAreCorrect() {
    let mockService = MockSecureNetworkService()
    
    XCTAssert(mockService.host == "httpbin.org")
    XCTAssert(mockService.scheme == "https")
    XCTAssertNil(mockService.port)
  }
}