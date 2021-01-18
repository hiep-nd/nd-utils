//
//  UIView+NDUtils.m
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 7/14/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIView+NDUtils.h>

#import <NDLog/NDLog.h>

@implementation UIView (NDUtils)

- (void)nd_forEach:(void(NS_NOESCAPE ^)(__kindof UIView*))handler {
  if (!handler) {
    NDAssertionFailure(@"Can not foreach UIView with handler: '%@'.", handler);
    return;
  }
  handler(self);
  [self.subviews
      enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL*) {
        [obj nd_forEach:handler];
      }];
}

- (void)nd_shakeWithDuration:(NSTimeInterval)duration
                 translation:(CGPoint)translation {
  auto animator = [[UIViewPropertyAnimator alloc]
      initWithDuration:duration
          dampingRatio:0.3
            animations:^{
              self.transform = CGAffineTransformMakeTranslation(translation.x,
                                                                translation.y);
            }];
  [animator
      addAnimations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
      }
        delayFactor:0.2];
  [animator startAnimation];
}

- (UIView*)nd_enableSeparatorWithHeight:(CGFloat)height
                                leading:(CGFloat)leading
                               trailing:(CGFloat)trailing
                                  color:(UIColor*)color {
  auto separatorView = [[UIView alloc] init];
  separatorView.backgroundColor = color;
  separatorView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:separatorView];
  [NSLayoutConstraint activateConstraints:@[
    [separatorView.heightAnchor constraintEqualToConstant:height],
    [separatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                constant:leading],
    [separatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                 constant:-trailing],
    [separatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
  ]];
  return separatorView;
}

@end
