//
//  NSObject+NDUtils_Foundation.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/12/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NDUtils_Foundation)

- (id<NSObject>)nd_observeKeyPath:(NSString*)keyPath
                          options:(NSKeyValueObservingOptions)options
                    changeHandler:(void (^)(id, NSDictionary*))changeHandler
    NS_SWIFT_UNAVAILABLE("Use observe(_, options:, changeHandler:) instead.");

@end

NS_ASSUME_NONNULL_END
