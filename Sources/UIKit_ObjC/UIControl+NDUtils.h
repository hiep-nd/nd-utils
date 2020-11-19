//
//  UIControl+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 7/28/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (NDUtils)

- (id<NSObject>)nd_events:(UIControlEvents)events
               addAction0:(void (^)(void))action
    NS_SWIFT_NAME(nd_(events:addAction:));

- (id<NSObject>)nd_events:(UIControlEvents)events
               addAction1:(void (^)(__kindof UIControl*))action
    NS_SWIFT_NAME(nd_(events:addAction:));

- (id<NSObject>)nd_events:(UIControlEvents)events
                addAction:(void (^)(__kindof UIControl*, UIEvent*))action
    NS_SWIFT_NAME(nd_(events:addAction:));

- (void)nd_removeActionHandle:(id<NSObject>)actionHandle
    NS_SWIFT_NAME(nd_remove(actionHandle:));

@end

NS_ASSUME_NONNULL_END
