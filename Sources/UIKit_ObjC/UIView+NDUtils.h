//
//  UIView+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 7/14/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NDUtils)

- (void)nd_forEach:(void(NS_NOESCAPE ^)(__kindof UIView*))handler
    NS_SWIFT_NAME(nd_forEach(_:));
- (void)nd_shakeWithDuration:(NSTimeInterval)duration
                 translation:(CGPoint)translation NS_REFINED_FOR_SWIFT
    API_AVAILABLE(ios(10.0));
- (UIView*)nd_enableSeparatorWithHeight:(CGFloat)height
                                leading:(CGFloat)leading
                               trailing:(CGFloat)trailing
                                  color:(UIColor*)color NS_REFINED_FOR_SWIFT;
@end

NS_ASSUME_NONNULL_END
