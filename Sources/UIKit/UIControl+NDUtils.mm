//
//  UIControl+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 7/28/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIControl+NDUtils.h>

#import <NDLog/NDLog.h>
#import <NDUtils/NDMacros+NDUtils.h>
#import <NDUtils/NDUITargetActionHandle.h>
#import <NDUtils/runtime+NDUtils.h>

using namespace nd::objc;

@interface NDUIControlActionHandle : NDUITargetActionHandle <UIControl*>

- (instancetype)initWithOwner:(UIControl*)owner
                       action:(void (^)(__kindof UIControl* _Nonnull,
                                        UIEvent* _Nonnull))action
    NS_UNAVAILABLE;

- (instancetype)initWithOwner:(UIControl*)control
                       events:(UIControlEvents)events
                       action:(void (^)(__kindof UIControl*, UIEvent*))action
    NS_DESIGNATED_INITIALIZER;

- (void)disconnectWithControl;

@end

@implementation NDUIControlActionHandle {
  UIControlEvents _events;
}

- (instancetype)initWithOwner:(UIControl*)owner
                       events:(UIControlEvents)events
                       action:(void (^)(__kindof UIControl*, UIEvent*))action {
  self = [super initWithOwner:owner action:action];
  if (self) {
    _events = events;
    if (owner && action) {
      [owner addTarget:self
                    action:@selector(actionWithSender:event:)
          forControlEvents:_events];
    }
  }
  return self;
}

- (void)disconnectWithControl {
  if (self.owner && self.action) {
    [self.owner removeTarget:self
                      action:@selector(actionWithSender:event:)
            forControlEvents:_events];
  }
}

- (void)dealloc {
  [self disconnectWithControl];
}

@end

@implementation UIControl (NDUtils)

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

- (id<NSObject>)nd_events:(UIControlEvents)events
               addAction0:(void (^)(void))action {
  return [self nd_events:events
               addAction:^(__kindof UIControl*, UIEvent*) {
                 NDCallIfCan(action);
               }];
}

- (id<NSObject>)nd_events:(UIControlEvents)events
               addAction1:(void (^)(__kindof UIControl*))action {
  return [self nd_events:events
               addAction:^(__kindof UIControl* sender, UIEvent*) {
                 NDCallIfCan(action, sender);
               }];
}

- (id<NSObject>)nd_events:(UIControlEvents)events
                addAction:(void (^)(__kindof UIControl*, UIEvent*))action {
  NDAssert(action, @"Can not add action: '%@'.", action);

  auto handle = [[NDUIControlActionHandle alloc] initWithOwner:self
                                                        events:events
                                                        action:action];
  [self.nd_actionHandles addObject:handle];
  return handle;
}

- (void)nd_removeActionHandle:(id<NSObject>)actionHandle {
  if (!actionHandle ||
      ![actionHandle isKindOfClass:NDUIControlActionHandle.class]) {
    NDAssertionFailure(@"Can not remove action handle: '%@'.", actionHandle);
    return;
  }

  [(NDUIControlActionHandle*)actionHandle disconnectWithControl];
  [self.nd_actionHandles removeObject:actionHandle];
}

@end
