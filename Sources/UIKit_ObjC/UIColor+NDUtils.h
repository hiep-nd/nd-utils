//
//  UIColor+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 5/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (NDUtils)

+ (instancetype)nd_withRgb:(UInt32)rgb NS_SWIFT_NAME(nd_(rgb:));
+ (instancetype)nd_withRgba:(UInt32)rgba NS_SWIFT_NAME(nd_(rgba:));
@property(nonatomic, readonly) UInt32 nd_rgb;
@property(nonatomic, readonly) UInt32 nd_rgba;

@end

NS_ASSUME_NONNULL_END
