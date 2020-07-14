//
//  NSObject+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 6/24/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NDUtils)

- (id<NSObject>)nd_observeKeyPath:(NSString*)keyPath
                          options:(NSKeyValueObservingOptions)options
                    changeHandler:(void (^)(id, NSDictionary*))changeHandler
    NS_SWIFT_UNAVAILABLE("Use observe(_, options:, changeHandler:) instead.");

@end

NS_ASSUME_NONNULL_END

inline BOOL NDSameOrEquals(id _Nullable lv, id _Nullable rv)
    NS_SWIFT_UNAVAILABLE("For ObjC only.") {
  return (lv == rv) || [lv isEqual:rv];
}
