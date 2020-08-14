//
//  NSObject+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 6/24/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <objc/NSObject.h>

#ifdef __cplusplus
namespace nd {
namespace objc {
inline bool SameOrEquals(id _Nullable lv, id _Nullable rv) {
  return (lv == rv) || [lv isEqual:rv];
}

template <typename T>
inline T* _Nullable Cast(id _Nullable obj) {
  return (obj && [obj isKindOfClass:[T class]]) ? static_cast<T*>(obj) : nil;
}

// template <typename T>
// inline id<T> PCast(NSObject* obj) {
//  return (obj && [obj conformsToProtocol:@protocol(T)]) ?
//  static_cast<id<T>>(obj) : nil;
//}
}  // namespace objc
}  // namespace nd
#endif
