//
//  UIFontTests.swift
//  NDUtilsTests
//
//  Created by Nguyen Duc Hiep on 5/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

import NDUtils
import XCTest

class UIFontTests: XCTestCase {
  func test_safe_InvalidName() throws {
    let font = UIFont.nd_safe(name: "asdasda", size: 2_131_231)
    XCTAssert(font == UIFont.systemFont(ofSize: 2_131_231))
  }

  func test_safe_ValidName() throws {
    let font = UIFont.nd_safe(name: "Helvetica", size: 20)
    XCTAssert(font.fontName == "Helvetica")
    XCTAssert(font.pointSize == 20)
  }
}
