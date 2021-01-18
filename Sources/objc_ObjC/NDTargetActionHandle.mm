//
//  NDTargetActionHandle.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NDTargetActionHandle.h>

#import <NDLog/NDLog.h>
#import <NDUtils/NDMacros+NDUtils.h>

@implementation NDAbstractBaseTargetActionHandle

- (void)disconnectWithOwner {
  NDDAssertionFailure(
      @"Reach abstract method. Please implement that in sub-class.");
}

- (void)dealloc {
  [self disconnectWithOwner];
}

@end

@implementation NDAbstractTargetActionHandle0

- (instancetype)initWithOwner:(id<NSObject>)owner
                       action:(void (^)(__kindof id<NSObject>))action {
  self = [super initWithOwner:owner];
  if (self) {
    self.action = action;
  }
  return self;
}

- (void)actionWithSender:(__kindof id<NSObject>)sender {
  NDCallAndReturnIfCan(self.action, sender);
}

@end

@implementation NDAbstractTargetActionHandle1

- (instancetype)initWithOwner:(id<NSObject>)owner
                       action:(void (^)(__kindof id<NSObject>,
                                        __kindof id<NSObject>))action {
  self = [super initWithOwner:owner];
  if (self) {
    self.action = action;
  }
  return self;
}

- (void)actionWithSender:(__kindof id<NSObject>)sender
                    para:(__kindof id<NSObject>)para {
  NDCallAndReturnIfCan(self.action, sender, para);
}

@end

@implementation NDAbstractTargetActionHandle2

- (instancetype)initWithOwner:(id<NSObject>)owner
                       action:(void (^)(__kindof id<NSObject>,
                                        __kindof id<NSObject>,
                                        __kindof id<NSObject>))action {
  self = [super initWithOwner:owner];
  if (self) {
    self.action = action;
  }
  return self;
}

- (void)actionWithSender:(__kindof id<NSObject>)sender
                   para0:(nonnull __kindof id<NSObject>)para0
                   para1:(nonnull __kindof id<NSObject>)para1 {
  NDCallAndReturnIfCan(self.action, sender, para0, para1);
}

@end

@implementation NDAbstractTargetActionHandle3

- (instancetype)initWithOwner:(id<NSObject>)owner
                       action:(void (^)(__kindof id<NSObject>,
                                        __kindof id<NSObject>,
                                        __kindof id<NSObject>,
                                        __kindof id<NSObject>))action {
  self = [super initWithOwner:owner];
  if (self) {
    self.action = action;
  }
  return self;
}

- (void)actionWithSender:(__kindof id<NSObject>)sender
                   para0:(nonnull __kindof id<NSObject>)para0
                   para1:(nonnull __kindof id<NSObject>)para1
                   para2:(nonnull __kindof id<NSObject>)para2 {
  NDCallAndReturnIfCan(self.action, sender, para0, para1, para2);
}

@end
