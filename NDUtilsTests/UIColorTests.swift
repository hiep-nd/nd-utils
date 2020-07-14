//
//  UIColorTests.swift
//  NDUtilsTests
//
//  Created by Nguyen Duc Hiep on 5/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

import XCTest

class UIColorTests: XCTestCase {
  func test_RGB() throws {
    let color = UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
    let rgb = color.nd_rgb
    XCTAssert((rgb & 0xFF0000) >> 16 == Int(0.1 * 255))
    XCTAssert((rgb & 0xFF00) >> 8 == Int(0.2 * 255))
    XCTAssert((rgb & 0xFF) == Int(0.3 * 255))
  }

  func test_RGBA() throws {
    let color = UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
    let rgba = color.nd_rgba
    XCTAssert((rgba & 0xFF00_0000) >> 24 == Int(0.1 * 255))
    XCTAssert((rgba & 0xFF0000) >> 16 == Int(0.2 * 255))
    XCTAssert((rgba & 0xFF00) >> 8 == Int(0.3 * 255))
    XCTAssert((rgba & 0xFF) == Int(0.4 * 255))
  }

  func test_withRGB() throws {
    let color: UIColor = .nd_(rgb: 0x123456)
    XCTAssert(color.nd_rgb == 0x123456)
  }

  func test_withRGBA() throws {
    let color: UIColor = .nd_(rgba: 0x1234_5678)
    XCTAssert(color.nd_rgba == 0x1234_5678)
  }

}
