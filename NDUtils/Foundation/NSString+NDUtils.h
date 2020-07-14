//
//  NSString+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 6/23/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NDUtils)

+ (instancetype)nd_stringNamed:(NSString*)name NS_SWIFT_NAME(nd_(named:));

@end

NS_ASSUME_NONNULL_END
