//
//  UIGestureRecognizer+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 16/12/2020.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIGestureRecognizer+NDUtils.h>

#import <NDLog/NDLog.h>
#import <NDUtils/NDMacros+NDUtils.h>
#import <NDUtils/runtime+NDUtils.h>

using namespace nd::objc;

@interface NDUIGestureRecognizerDelegateHandlers () <
    UIGestureRecognizerDelegate>
@end

@implementation NDUIGestureRecognizerDelegateHandlers

@synthesize shouldBegin;
@synthesize shouldRecognizeSimultaneouslyWithGestureRecognizer;
@synthesize shouldRequireFailureOfGestureRecognizer;
@synthesize shouldReceiveTouch;
@synthesize shouldReceivePress;
@synthesize shouldReceiveEvent;
@synthesize shouldBeRequiredToFailByGestureRecognizer;

- (instancetype)initWithOwner:(UIGestureRecognizer*)owner {
  self = [super initWithOwner:owner];
  if (self) {
    owner.delegate = self;
  }
  return self;
}

// MARK: - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
  if (self.owner != gestureRecognizer) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self,
                       gestureRecognizer);
  } else {
    NDCallAndReturnIfCan(self.shouldBegin, gestureRecognizer);
  }
  return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:
        (UIGestureRecognizer*)otherGestureRecognizer {
  if (self.owner != gestureRecognizer) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self,
                       gestureRecognizer);
  } else {
    NDCallAndReturnIfCan(
        self.shouldRecognizeSimultaneouslyWithGestureRecognizer,
        gestureRecognizer, otherGestureRecognizer);
  }
  return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
    shouldRequireFailureOfGestureRecognizer:
        (UIGestureRecognizer*)otherGestureRecognizer {
  if (self.owner != gestureRecognizer) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self,
                       gestureRecognizer);
  } else {
    NDCallAndReturnIfCan(self.shouldRequireFailureOfGestureRecognizer,
                         gestureRecognizer, otherGestureRecognizer);
  }
  return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
    shouldBeRequiredToFailByGestureRecognizer:
        (UIGestureRecognizer*)otherGestureRecognizer {
  if (self.owner != gestureRecognizer) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self,
                       gestureRecognizer);
  } else {
    NDCallAndReturnIfCan(self.shouldBeRequiredToFailByGestureRecognizer,
                         gestureRecognizer, otherGestureRecognizer);
  }
  return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
       shouldReceiveTouch:(UITouch*)touch {
  if (self.owner != gestureRecognizer) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self,
                       gestureRecognizer);
  } else {
    NDCallAndReturnIfCan(self.shouldReceiveTouch, gestureRecognizer, touch);
  }
  return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
       shouldReceivePress:(UIPress*)press {
  if (self.owner != gestureRecognizer) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self,
                       gestureRecognizer);
  } else {
    NDCallAndReturnIfCan(self.shouldReceivePress, gestureRecognizer, press);
  }
  return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
       shouldReceiveEvent:(UIEvent*)event {
  if (self.owner != gestureRecognizer) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self,
                       gestureRecognizer);
  } else {
    if (@available(iOS 13.4, *)) {
      NDCallAndReturnIfCan(self.shouldReceiveEvent, gestureRecognizer, event);
    }
  }
  return YES;
}

@end

@implementation UIGestureRecognizer (NDUtils)

namespace {
id UIGestureRecognizer_nd_delegateHandlers_creator(id owner) {
  return [[NDUIGestureRecognizerDelegateHandlers alloc] initWithOwner:owner];
}
}

- (id<NDUIGestureRecognizerDelegateHandlers>)nd_delegateHandlers {
  return GetAssociatedObject<UIGestureRecognizer_nd_delegateHandlers_creator,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
      self, @selector(nd_delegateHandlers));
}

@end
