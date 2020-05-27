//
//  UIFont+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 5/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (NDUtils)
+ (instancetype)nd_safeWithName:(NSString*)name
                           size:(CGFloat)size
    NS_SWIFT_NAME(nd_safe(name:size:));
@end

NS_ASSUME_NONNULL_END
