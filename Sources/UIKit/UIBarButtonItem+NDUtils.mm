//
//  UIBarButtonItem+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIBarButtonItem+NDUtils.h>

#import <NDLog/NDLog.h>
#import <NDUtils/NDPossession.h>
#import <NDUtils/NDUITargetActionHandle.h>
#import <NDUtils/runtime+NDUtils.h>

using namespace nd::objc;

@interface NDUIBarButtonItemActionHandle
    : NDUITargetActionHandle <UIBarButtonItem*>
@end

@implementation NDUIBarButtonItemActionHandle

- (instancetype)initWithOwner:(UIBarButtonItem*)owner
                       action:(void (^)(__kindof id<NSObject> _Nonnull,
                                        UIEvent* _Nonnull))action {
  self = [super initWithOwner:owner action:action];
  if (self) {
    if (owner && action) {
      owner.target = self;
      owner.action = @selector(actionWithSender:event:);
    }
  }
  return self;
}

- (void)dealloc {
  __unsafe_unretained auto owner = self.owner;
  if (owner && owner.target == self &&
      owner.action == @selector(actionWithSender:event:)) {
    owner.target = nil;
    owner.action = nil;
  }
}

@end

@implementation UIBarButtonItem (NDUtils)

- (NDUIBarButtonItemActionHandle*)nd_actionHandle {
  return PeekAssociatedObject<NDUIBarButtonItemActionHandle*>(
      self, @selector(nd_actionHandle));
}

- (void (^)(__kindof UIBarButtonItem*, UIEvent*))nd_action {
  return self.nd_actionHandle.action;
}

- (void)setNd_action:(void (^)(__kindof UIBarButtonItem*, UIEvent*))nd_action {
  auto handle = nd_action ? [[NDUIBarButtonItemActionHandle alloc]
                                initWithOwner:self
                                       action:nd_action]
                          : nil;
  SetAssociatedObject<OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
      self, @selector(nd_actionHandle), handle);
}

- (void)setNd_action0:(void (^)(void))nd_action0 {
  if (nd_action0) {
    self.nd_action = ^(UIBarButtonItem*, UIEvent*) {
      nd_action0();
    };
  } else {
    self.nd_action = nil;
  }
}

- (void)setNd_action1:(void (^)(__kindof UIBarButtonItem*))nd_action1 {
  if (nd_action1) {
    self.nd_action = ^(UIBarButtonItem* owner, UIEvent*) {
      nd_action1(owner);
    };
  } else {
    self.nd_action = nil;
  }
}

@end
