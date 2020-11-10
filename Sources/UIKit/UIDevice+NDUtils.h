//
//  UIDevice+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/14/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (NDUtils)

/// Hardware type
@property(nonatomic, strong, readonly) NSString* nd_name;

/// Name of OS
@property(nonatomic, strong, readonly) NSString* nd_os;

/// Name of this network node
@property(nonatomic, strong, readonly) NSString* nd_networkNode;

/// Release level
@property(nonatomic, strong, readonly) NSString* nd_release;

/// Version level
@property(nonatomic, strong, readonly) NSString* nd_version;

@end

NS_ASSUME_NONNULL_END
