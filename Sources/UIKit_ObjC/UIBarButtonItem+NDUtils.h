//
//  UIBarButtonItem+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NDUIBarButtonItemActionHandlers

@property(nonatomic, copy) void (^_Nullable nd_action)
    (__kindof UIBarButtonItem*, UIEvent*);
- (void)setNd_action0:(void (^_Nullable)(void))nd_action0
    NS_SWIFT_NAME(nd_set(action:));
- (void)setNd_action1:(void (^_Nullable)(__kindof UIBarButtonItem*))nd_action1
    NS_SWIFT_NAME(nd_set(action:));

@end

@interface UIBarButtonItem (NDUtils) <NDUIBarButtonItemActionHandlers>

@end

NS_ASSUME_NONNULL_END
