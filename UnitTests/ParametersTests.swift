//
//  UnitTests.swift
//  UnitTests
//
//  Created by Tarun Sharma on 27/06/16.
//  Copyright © 2016 Talentica. All rights reserved.
//

import XCTest
@testable import TalNet

class ParametersTests: XCTestCase {
  
  var parameters: Parameters!
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
    parameters = Parameters()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testThatOnEmptyInitializationParameterDictionaryIsEmpty() {
    
    XCTAssertNotNil(parameters,"Parameters should not be nil")
    XCTAssert(parameters.parameterDictionary.isEmpty, "Parameter Dictionary should be empty.")
  }
  
  func testThatParametersDictionarySubscriptWorksCorrectly() {
    
    parameters?["foo"] = "bar"
    let value = parameters["foo"] as! String
    XCTAssert(value == "bar", "Parameter dictionary's foo value should be bar")
    
  }
}
