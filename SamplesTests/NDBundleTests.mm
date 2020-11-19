//
//  NDBundleTests.mm
//  NDUtilsTests
//
//  Created by Nguyen Duc Hiep on 10/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <NDUtils/NDUtils.h>

using namespace nd::objc;

@interface NDBundleTests : XCTestCase

@end

@implementation NDBundleTests

- (void)test_SubBundle {
  XCTAssertEqualObjects(NSBundle.mainBundle, SubBundle(NDEvent.class, nil));
}

- (void)test_CFBundleVersion {
  XCTAssertEqualObjects(@"1", NSBundle.mainBundle.nd_CFBundleVersion);
}

- (void)test_CFBundleShortVersionString {
  XCTAssertEqualObjects(@"1.0",
                        NSBundle.mainBundle.nd_CFBundleShortVersionString);
}

- (void)test_CFBundleInfoDictionaryVersion {
  XCTAssertEqualObjects(@"6.0",
                        NSBundle.mainBundle.nd_CFBundleInfoDictionaryVersion);
}

- (void)test_NSHumanReadableCopyright {
  XCTAssertEqualObjects(nil, NSBundle.mainBundle.nd_NSHumanReadableCopyright);
}

@end
