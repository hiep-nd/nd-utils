//
//  runtime.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <objc/runtime.h>

#ifdef __cplusplus
namespace nd {
namespace objc {
template <typename T>
inline T PeekAssociatedObject(id _Nonnull object, const void* _Nonnull key) {
  return (T)objc_getAssociatedObject(object, key);
}

template <objc_AssociationPolicy policy>
inline void SetAssociatedObject(id _Nonnull object,
                                const void* _Nonnull key,
                                id _Nullable value) {
  objc_setAssociatedObject(object, key, value, policy);
}

template <id (*creator)(id _Nullable), objc_AssociationPolicy policy>
inline id _Nonnull GetAssociatedObject(id _Nonnull object,
                                       const void* _Nonnull key) {
  id obj = PeekAssociatedObject<id>(object, key);
  if (!obj) {
    obj = creator(object);
    SetAssociatedObject<policy>(object, key, obj);
  }
  return obj;
}
}  // namespace objc
}  // namespace nd
#endif
