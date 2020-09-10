//
//  NDUITargetActionHandle.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NDUITargetActionHandle.h>

#import <NDUtils/NDMacros+NDUtils.h>

@implementation NDUITargetActionHandle

- (instancetype)initWithOwner:(id<NSObject>)owner
                       action:
                           (void (^)(__kindof id<NSObject>, UIEvent*))action {
  self = [super initWithOwner:owner];
  if (self) {
    self.action = action;
  }
  return self;
}

- (void)actionWithSender:(UIBarButtonItem*)sender event:(UIEvent*)event {
  NDCallAndReturnIfCan(self.action, sender, event);
}

@end
