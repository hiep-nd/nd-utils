//
//  UIView+NDUtils.m
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 7/14/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIKit/UIView+NDUtils.h>

#import <NDLog/NDLog.h>

@implementation UIView (NDUtils)

- (void)nd_forEach:(void(NS_NOESCAPE ^)(__kindof UIView*))handler {
  if (!handler) {
    NDAssertFailure(@"Can not foreach UIView with handler: '%@'.", handler);
    return;
  }
  handler(self);
  [self.subviews
      enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL*) {
        [obj nd_forEach:handler];
      }];
}

@end
