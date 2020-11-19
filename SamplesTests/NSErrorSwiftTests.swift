//
//  NSErrorSwiftTests.swift
//  SamplesTests
//
//  Created by Nguyen Duc Hiep on 17/11/2020.
//

import XCTest

import NDUtils

class NSErrorSwiftTests: XCTestCase {
  func test_nd_runtimeError() throws {
    let error = nd_runtimeError(with: "message", tag: "tag")

    XCTAssertEqual(kNDErrorDomain, error.domain)
    XCTAssertEqual(kNDErrorCodeRuntime, error.code)
    XCTAssertEqual("message", error.userInfo[kNDMessageKey] as? String)
    XCTAssertEqual("tag", error.userInfo[kNDTagKey] as? String)
    XCTAssertEqual("test_nd_runtimeError()", error.userInfo[kNDFunctionKey] as? String)
    XCTAssertEqual(#file, error.userInfo[kNDFileKey] as? String)
    XCTAssertEqual(14, error.userInfo[kNDLineKey] as? UInt)
  }
}
