//
//  NSStringTests.swift
//  NDUtilsTests
//
//  Created by Nguyen Duc Hiep on 9/28/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

import NDUtils
import XCTest

class NSStringTests: XCTestCase {
  func test_nd_containsRegexPattern() {
    XCTAssertEqual(true, NSString("hat").nd_contains(regexPattern: "[a-z]at"))
    XCTAssertEqual(true, NSString("hhat").nd_contains(regexPattern: "[a-z]at"))
    XCTAssertEqual(true, NSString("hatt").nd_contains(regexPattern: "[a-z]at"))
    XCTAssertEqual(false, NSString("hat").nd_contains(regexPattern: "[csm]at"))
    XCTAssertEqual(true, NSString("card").nd_contains(regexPattern: "c[a-z]*d"))
  }

  func test_nd_matchsRegexPattern() {
    XCTAssertEqual(true, NSString("hat").nd_matchs(regexPattern: "[a-z]at"))
    XCTAssertEqual(false, NSString("hhat").nd_matchs(regexPattern: "[a-z]at"))
    XCTAssertEqual(false, NSString("hatt").nd_matchs(regexPattern: "[a-z]at"))
  }
}
