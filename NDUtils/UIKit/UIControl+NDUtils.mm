//
//  UIControl+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 7/28/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIKit/UIControl+NDUtils.h>

#import <NDLog/NDLog.h>
#import <NDUtils/Foundation/NDMacros.h>
#import <objc/runtime.h>

@interface NDUIControlActionHandle : NSObject

- (instancetype)initWithControl:(UIControl*)control
                         events:(UIControlEvents)events
                         action:(void (^)(__kindof UIControl*, UIEvent*))action;
- (void)removeFromControl;

@end

@implementation NDUIControlActionHandle {
  __weak UIControl* _control;
  UIControlEvents _events;
  void (^_action)(__kindof UIControl*, UIEvent*);
}

- (instancetype)initWithControl:(UIControl*)control
                         events:(UIControlEvents)events
                         action:
                             (void (^)(__kindof UIControl*, UIEvent*))action {
  self = [super init];
  if (self) {
    _control = control;
    _events = events;
    _action = [action copy];

    if (_control && _action) {
      [_control addTarget:self
                    action:@selector(actionWithSender:event:)
          forControlEvents:_events];
    }
  }
  return self;
}

- (void)removeFromControl {
  if (_control && _action) {
    [_control removeTarget:self
                    action:@selector(actionWithSender:event:)
          forControlEvents:_events];
    _control = nil;
    _action = nil;
  }
}

- (void)dealloc {
  [self removeFromControl];
}

- (void)actionWithSender:(UIControl*)sender event:(UIEvent*)event {
  NDCallAndReturnIfCan(_action, sender, event);
}

@end

@implementation UIControl (NDUtils)

- (NSMutableArray*)nd_actionHandles {
  NSMutableArray* obj =
      objc_getAssociatedObject(self, @selector(nd_actionHandles));
  if (obj == nil) {
    obj = [[NSMutableArray alloc] init];
    objc_setAssociatedObject(self, @selector(nd_actionHandles), obj,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

  auto handle = [[NDUIControlActionHandle alloc] initWithControl:self
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

  [(NDUIControlActionHandle*)actionHandle removeFromControl];
  [self.nd_actionHandles removeObject:actionHandle];
}

@end
