//
//  NDHandlersTests.m
//  SamplesTests
//
//  Created by Nguyen Duc Hiep on 07/01/2021.
//  Copyright © 2021 Nguyen Duc Hiep. All rights reserved.
//

#import <XCTest/XCTest.h>

@protocol Abc <NSObject>

@required
- (void)requiredWithBOOL:(BOOL)b NSObject:(NSObject*)obj;

@optional
- (void)optional;

@end

@interface Abc : NSObject <Abc>

@property(nonatomic, copy) void (^_Nullable requiredWithBOOLNSObject)
    (BOOL, NSObject*);
@property(nonatomic, copy) void (^_Nullable optionalHandler)();

@end

@implementation Abc

//- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {
//  //  if (selector == @selector(required) && self.requiredHandler) {
//  //    return <#expression#>;
//  //  }
//
//  return [super methodSignatureForSelector:selector];
//
//  //  NSMethodSignature* signature = [super
//  //  methodSignatureForSelector:selector]; if (signature)
//  //    return signature;
//  //
//  //  // Look for a required method in the protocol.
//  //  protocol_getMethodDescription
//  //  // returns a struct whose fields are null if a method for the selector
//  //  was
//  //  // not found.
//  //  struct objc_method_description description =
//  //      protocol_getMethodDescription(self.protocol, selector, YES, YES);
//  //  if (description.types)
//  //    return [NSMethodSignature signatureWithObjCTypes:description.types];
//  //
//  //  // Look for an optional method in the protocol.
//  //  description = protocol_getMethodDescription(self.protocol, selector, NO,
//  //  YES); if (description.types)
//  //    return [NSMethodSignature signatureWithObjCTypes:description.types];
//  //
//  //  // There is neither a required nor optional method with this selector in
//  //  the
//  //  // protocol, so invoke -[NSObject doesNotRecognizeSelector:] to raise
//  //  // NSInvalidArgumentException.
//  //  [self doesNotRecognizeSelector:selector];
//  return nil;
//}

- (void)forwardInvocation:(NSInvocation*)invocation {
  if (invocation.target == self) {
    if (invocation.selector == @selector(requiredWithBOOL:NSObject:) &&
        self.requiredWithBOOLNSObject) {
      BOOL b;
      NSObject* obj;
      [invocation getArgument:&b atIndex:2];
      [invocation getArgument:&obj atIndex:3];
      self.requiredWithBOOLNSObject(b, obj);
      return;
    }

    invocation.selector;
  }

  [super forwardInvocation:invocation];
  //  DCHECK(invocation);
  //  if (_observers.empty())
  //    return;
  //  SEL selector = [invocation selector];
  //  Iterator it(self);
  //  id observer;
  //  while ((observer = it.GetNext()) != nil) {
  //    if ([observer respondsToSelector:selector])
  //      [invocation invokeWithTarget:observer];
  //  }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
  if (aSelector == @selector(requiredWithBOOL:NSObject:)) {
    return self.requiredWithBOOLNSObject;
  }

  return [super respondsToSelector:aSelector];
}
@end

@interface NDHandlersTests : XCTestCase
@end

@implementation NDHandlersTests

- (void)test {
  auto obj = [[Abc alloc] init];

  XCTAssertFalse([obj respondsToSelector:@selector(xyz)]);

  XCTAssertFalse([obj respondsToSelector:@selector(requiredWithBOOL:
                                                           NSObject:)]);
  XCTAssertThrows([obj requiredWithBOOL:YES NSObject:@"123"]);

  __block auto checkPoint = NO;
  obj.requiredWithBOOLNSObject = ^(BOOL b, NSObject* obj) {
    NSLog(@"requiredWithBOOL:NSObject: - %d - %@", b, obj);
    checkPoint = YES;
  };
  XCTAssertTrue([obj respondsToSelector:@selector(requiredWithBOOL:NSObject:)]);
  checkPoint = NO;
  [obj requiredWithBOOL:YES NSObject:@"123"];
  XCTAssertTrue(checkPoint);
  //
  //  obj.optionalHandler = ^{
  //    NSLog(@"optionalHandler");
  //  };
}

@end
