//
//  NSDictionary+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 06/01/2021.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus

#import <NDUtils/NSObject+NDUtils.h>

NS_ASSUME_NONNULL_BEGIN

namespace nd {
namespace objc {
template <typename T, bool safe = false>
inline T* _Nullable Get(__kindof NSDictionary* _Nullable container,
                        NSString* key) {
  if (safe && (!key)) {
    return nil;
  }

  return Cast<T>(container[key]);
}

template <typename T, bool safe = false>
inline T* _Nullable Get(__kindof NSDictionary* _Nullable container,
                        NSString* key,
                        T* _Nullable defaultValue) {
  if (safe && (!key)) {
    return nil;
  }

  return Cast<T>(container[key]) ?: defaultValue;
}

template <typename T, bool safe = false>
inline T* _Nullable Get(__kindof NSDictionary* _Nullable container,
                        NSString* key,
                        T* _Nullable defaultValue,
                        bool& success) {
  if (safe && (!key)) {
    success = false;
    return nil;
  }

  auto value = Cast<T>(container[key]);
  if (!value) {
    success = false;
    return defaultValue;
  }

  success = true;
  return value;
}
}  // namespace objc
}  // namespace nd

NS_ASSUME_NONNULL_END

#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (NDUtils)

@end

NS_ASSUME_NONNULL_END
