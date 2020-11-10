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

@end
