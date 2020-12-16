//
//  runtime.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <objc/runtime.h>

#ifdef __cplusplus

#import <vector>

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

inline void SwizzleMethod(Class _Nonnull cls,
                          SEL _Nonnull sel,
                          SEL _Nonnull newSel) {
  auto originalMethod = class_getInstanceMethod(cls, sel);
  auto swizzledMethod = class_getInstanceMethod(cls, newSel);
  BOOL didAddMethod =
      class_addMethod(cls, sel, method_getImplementation(swizzledMethod),
                      method_getTypeEncoding(swizzledMethod));
  if (didAddMethod) {
    class_replaceMethod(cls, newSel, method_getImplementation(originalMethod),
                        method_getTypeEncoding(originalMethod));
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}

inline void SwizzleMethods(
    Class _Nonnull cls,
    const std::vector<std::tuple<SEL _Nonnull, SEL _Nonnull>>& sels) {
  for (auto& sel : sels) {
    SwizzleMethod(cls, std::get<0>(sel), std::get<1>(sel));
  }
}

}  // namespace objc
}  // namespace nd
#endif
