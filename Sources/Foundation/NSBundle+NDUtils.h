//
//  NSBundle+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 10/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef __cplusplus
namespace nd {
namespace objc {
inline NSBundle* SubBundle(Class containerCls, NSString* name) {
  auto bundle = [NSBundle bundleForClass:containerCls];
  auto path = [bundle pathForResource:name ofType:@"bundle"];
  return [NSBundle bundleWithPath:path] ?: NSBundle.mainBundle;
}
}
}
#endif

FOUNDATION_EXPORT
NSBundle* NDSubBundle(Class containerCls, NSString* name);

NS_ASSUME_NONNULL_END
