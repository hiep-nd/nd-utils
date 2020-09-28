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
  func test_nd_urlSubdomain() {
    XCTAssertNil(NSString(string: "").nd_urlSubdomain())
    XCTAssertNil(NSString(string: "abcxyz").nd_urlSubdomain())
    XCTAssertNil(NSString(string: "a://bc.xyz").nd_urlSubdomain())
    XCTAssertEqual("bc", NSString(string: "a://bc.xy.z").nd_urlSubdomain())
    XCTAssertEqual("bc.x", NSString(string: "a://bc.x.y.z").nd_urlSubdomain())
  }

  func test_nd_urlDomain() {
    XCTAssertNil(NSString(string: "").nd_urlDomain())
    XCTAssertNil(NSString(string: "abc.xyz").nd_urlDomain())
    XCTAssertEqual("bc.xyz", NSString(string: "a://bc.xyz").nd_urlDomain())
    XCTAssertEqual("xy.z", NSString(string: "a://bc.xy.z").nd_urlDomain())
    XCTAssertEqual("y.z", NSString(string: "a://bc.x.y.z").nd_urlDomain())
  }

  func test_nd_urlTopLevelDomain() {
    XCTAssertNil(NSString(string: "").nd_urlTopLevelDomain())
    XCTAssertNil(NSString(string: "abcxyz").nd_urlTopLevelDomain())
    XCTAssertNil(NSString(string: "abc.xyz").nd_urlTopLevelDomain())
    XCTAssertEqual("z", NSString(string: "a://bc.xy.z").nd_urlTopLevelDomain())
    XCTAssertEqual("z", NSString(string: "a://bc.x.y.z").nd_urlTopLevelDomain())
  }

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
