//
//  NSFastEnumeration+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef __cplusplus
namespace nd {
namespace objc {
inline BOOL Contain(id<NSFastEnumeration> container, BOOL (^conditioner)(id)) {
  if (!conditioner) {
    return NO;
  }

  for (__unsafe_unretained id obj in container) {
    if (conditioner(obj)) {
      return YES;
    }
  }
  return NO;
}
}
}
#endif

NS_ASSUME_NONNULL_END
