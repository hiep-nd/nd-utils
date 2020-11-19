//
//  NSErrorTests.mm
//  SamplesTests
//
//  Created by Nguyen Duc Hiep on 17/11/2020.
//

#import <XCTest/XCTest.h>

#import <NDUtils/NDUtils.h>

@interface NSErrorTests : XCTestCase

@end

@implementation NSErrorTests

- (void)test_NDRuntimeError {
  NSError* error = NDRuntimeError(@"message");
  XCTAssertEqualObjects(kNDErrorDomain, error.domain);
  XCTAssertEqual(kNDErrorCodeRuntime, error.code);
  XCTAssertEqualObjects(@"message", error.userInfo[kNDMessageKey]);
  XCTAssertNil(error.userInfo[kNDTagKey]);
  XCTAssertEqualObjects(@"-[NSErrorTests test_NDRuntimeError]",
                        error.userInfo[kNDFunctionKey]);
  XCTAssertTrue([error.userInfo[kNDFileKey] hasSuffix:@"NSErrorTests.mm"]);
  XCTAssertEqualObjects(@(19), error.userInfo[kNDLineKey]);
}

- (void)test_NDRuntimeErrorTag {
  NSError* error = NDRuntimeErrorTag(@"message", @"tag");
  XCTAssertEqualObjects(kNDErrorDomain, error.domain);
  XCTAssertEqual(kNDErrorCodeRuntime, error.code);
  XCTAssertEqualObjects(@"message", error.userInfo[kNDMessageKey]);
  XCTAssertEqualObjects(@"tag", error.userInfo[kNDTagKey]);
  XCTAssertEqualObjects(@"-[NSErrorTests test_NDRuntimeErrorTag]",
                        error.userInfo[kNDFunctionKey]);
  XCTAssertTrue([error.userInfo[kNDFileKey] hasSuffix:@"NSErrorTests.mm"]);
  XCTAssertEqualObjects(@(31), error.userInfo[kNDLineKey]);
}

@end
