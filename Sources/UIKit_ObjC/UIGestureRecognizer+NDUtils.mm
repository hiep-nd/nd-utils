//
//  UIGestureRecognizer+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 16/12/2020.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIGestureRecognizer+NDUtils.h>

#import <NDUtils/NDTargetActionHandle.h>

#import <NDLog/NDLog.h>
#import <NDUtils/objc+NDUtils.h>

#import <map>

using namespace nd::objc;
using namespace std;

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

// MARK: - UIGestureRecognizerDelegate - optionals
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
  if (self.owner != gestureRecognizer) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self,
                       gestureRecognizer);
  } else {
    NDCallAndReturnIfCan(self.shouldBegin, gestureRecognizer);
    NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                       __PRETTY_FUNCTION__,
                       NSStringFromSelector(@selector(shouldBegin)));
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
    NDAssertionFailure(
        @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
        NSStringFromSelector(
            @selector(shouldRecognizeSimultaneouslyWithGestureRecognizer)));
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
    NDAssertionFailure(
        @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
        NSStringFromSelector(@selector
                             (shouldRequireFailureOfGestureRecognizer)));
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
    NDAssertionFailure(
        @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
        NSStringFromSelector(@selector
                             (shouldBeRequiredToFailByGestureRecognizer)));
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
    NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                       __PRETTY_FUNCTION__,
                       NSStringFromSelector(@selector(shouldReceiveTouch)));
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
    NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                       __PRETTY_FUNCTION__,
                       NSStringFromSelector(@selector(shouldReceivePress)));
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
    NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                       __PRETTY_FUNCTION__,
                       NSStringFromSelector(@selector(shouldReceiveEvent)));
  }
  return YES;
}

// MARK:- NSObject
- (BOOL)respondsToSelector:(SEL)aSelector {
  // clang-format off
  static auto selectorsMap = ([]() {
    auto builder = map<SEL, BOOL (^)(NDUIGestureRecognizerDelegateHandlers*)>({
      {
        @selector(gestureRecognizerShouldBegin:),
        ^BOOL(NDUIGestureRecognizerDelegateHandlers* self) {
          return self.shouldBegin != nil;
        }
      },
      {
        @selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:),
        ^BOOL(NDUIGestureRecognizerDelegateHandlers* self) {
          return self.shouldRecognizeSimultaneouslyWithGestureRecognizer!= nil;
        }
      },
      {
        @selector(gestureRecognizer:shouldRequireFailureOfGestureRecognizer:),
        ^BOOL(NDUIGestureRecognizerDelegateHandlers* self) {
          return self.shouldRequireFailureOfGestureRecognizer!= nil;
        }
      },
      {
        @selector(gestureRecognizer:shouldBeRequiredToFailByGestureRecognizer:),
        ^BOOL(NDUIGestureRecognizerDelegateHandlers* self) {
          return self.shouldBeRequiredToFailByGestureRecognizer!= nil;
        }
      },
      {
        @selector(gestureRecognizer:shouldReceiveTouch:),
        ^BOOL(NDUIGestureRecognizerDelegateHandlers* self) {
          return self.shouldReceiveTouch!= nil;
        }
      },
      {
        @selector(gestureRecognizer:shouldReceivePress:),
        ^BOOL(NDUIGestureRecognizerDelegateHandlers* self) {
          return self.shouldReceivePress!= nil;
        }
      }
    });

    if (@available(iOS 13.4, *)) {
      builder.insert({
        {
          @selector(gestureRecognizer:shouldReceiveEvent:),
          ^BOOL(NDUIGestureRecognizerDelegateHandlers* self) {
            return self.shouldReceiveEvent!= nil;
          }
        }
      });
    }

    return builder;
  })();

  auto it = selectorsMap.find(aSelector);
  if (it != selectorsMap.end()) {
    return it->second(self);
  }

  return [super respondsToSelector:aSelector];
// clang-format on
}

@end

@interface NDUIGestureRecognizerActionHandle
    : NDAbstractTargetActionHandle0 <UIGestureRecognizer*, UIGestureRecognizer*>
@end

@implementation NDUIGestureRecognizerActionHandle

- (instancetype)initWithOwner:(UIGestureRecognizer*)owner
                       action:(void (^)(__kindof id<NSObject>))action {
  self = [super initWithOwner:owner action:action];
  if (self) {
    if (action) {
      [owner addTarget:self action:@selector(actionWithSender:)];
    }
  }
  return self;
}

- (void)disconnectWithOwner {
  if (self.owner && self.action) {
    [self.owner removeTarget:self action:@selector(actionWithSender:)];
    self.action = nil;
  }
}

@end

@implementation UIGestureRecognizer (NDUtils)

// MARK:- Delegate handlers

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

// MARK: - Action handlers
- (NSMutableArray*)nd_actionHandles {
  auto obj =
      PeekAssociatedObject<NSMutableArray*>(self, @selector(nd_actionHandles));
  if (obj == nil) {
    obj = [[NSMutableArray alloc] init];
    SetAssociatedObject<OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
        self, @selector(nd_actionHandles), obj);
  }
  return obj;
}

- (id<NSObject>)nd_addAction0:(void (^)(void))action {
  return [self nd_addAction:^(__kindof UIGestureRecognizer*) {
    NDCallIfCan(action);
  }];
}

- (id<NSObject>)nd_addAction:(void (^)(__kindof UIGestureRecognizer*))action {
  if (!action) {
    NDAssertionFailure(@"Can not add action: '%@'.", action);
    return nil;
  }

  auto handle =
      [[NDUIGestureRecognizerActionHandle alloc] initWithOwner:self
                                                        action:action];
  [self.nd_actionHandles addObject:handle];
  return handle;
}

- (void)nd_removeActionHandle:(id<NSObject>)actionHandle {
  if (!actionHandle ||
      ![actionHandle isKindOfClass:NDUIGestureRecognizerActionHandle.class]) {
    NDAssertionFailure(@"Can not remove action handle: '%@'.", actionHandle);
    return;
  }

  [(NDUIGestureRecognizerActionHandle*)actionHandle disconnectWithOwner];
  [self.nd_actionHandles removeObject:actionHandle];
}

@end
