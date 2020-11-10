//
//  NDEvent.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/3/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NDEvent.h>

#import <NDLog/NDLog.h>
#import <NDUtils/NDMacros+NDUtils.h>

@implementation NDEvent

- (void)on {
  if (!self.owner) {
    NDAssertionFailure(@"Can not on with owner: '%@'.", self.owner);
    return;
  }

  NDCallAndReturnIfCan(self.handler, self.owner);
}

- (void)addHandler:(void (^)(id<NSObject> _Nonnull))handler {
  if (!handler) {
    NDAssertionFailure(@"Can not add handler: '%@' to event: '%@'.", handler,
                       self);
    return;
  }
  auto oldHandler = self.handler;
  _handler = ^(id owner) {
    NDCallIfCan(oldHandler, owner);
    NDCallIfCan(handler, owner);
  };
}

- (void)updateHandler:(void (^)(void (^_Nullable)(id<NSObject> _Nonnull),
                                id<NSObject> _Nonnull))handler {
  if (!handler) {
    self.handler = nil;
    return;
  }

  auto oldHandler = self.handler;
  _handler = ^(id owner) {
    handler(oldHandler, owner);
  };
}

+ (instancetype)eventWithOwner:(NSObject*)owner
                       handler:(void (^)(id<NSObject>))handler {
  NDEvent* obj = [[self alloc] initWithOwner:owner];

  if (!handler) {
    NDAssertionFailure(@"Can not create event with handler: '%@'.", handler);
    return obj;
  }

  obj->_handler = handler;
  return obj;
}
@end
