//
//  runtime.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <objc/runtime.h>

#ifdef __cplusplus

#import <NDUtils/NSObject+NDUtils.h>

#import <NDLog/NDLog.h>

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

template <objc_AssociationPolicy policy, typename T>
/// Default nonatomic setter (without self).
/// @param lv the variable.
/// @param rv the value.
/// @param policy is
/// OBJC_ASSOCIATION_ASSIGN|OBJC_ASSOCIATION_RETAIN_NONATOMIC|OBJC_ASSOCIATION_COPY_NONATOMIC.
void Set(T& lv, T rv) {
  static_assert(policy == OBJC_ASSOCIATION_ASSIGN ||
                    policy == OBJC_ASSOCIATION_RETAIN_NONATOMIC ||
                    policy == OBJC_ASSOCIATION_COPY_NONATOMIC,
                "Nonatomic set with atomic policy.");

  if (SameOrEquals(lv, rv)) {
    return;
  }

  if (policy == OBJC_ASSOCIATION_ASSIGN ||
      policy == OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
    lv = rv;
  } else if (policy == OBJC_ASSOCIATION_COPY_NONATOMIC) {
    lv = [rv copy];
  }
}

template <objc_AssociationPolicy policy, typename T>
/// Default setter.
/// @param self the self.
/// @param lv the variable.
/// @param rv the value.
void Set(id _Nonnull self, T& lv, T rv) {
  static_assert(policy == OBJC_ASSOCIATION_ASSIGN ||
                    policy == OBJC_ASSOCIATION_RETAIN_NONATOMIC ||
                    policy == OBJC_ASSOCIATION_COPY_NONATOMIC ||
                    policy == OBJC_ASSOCIATION_RETAIN ||
                    policy == OBJC_ASSOCIATION_COPY,
                "Set with invalid policy.");

  if (policy == OBJC_ASSOCIATION_ASSIGN ||
      policy == OBJC_ASSOCIATION_RETAIN_NONATOMIC ||
      policy == OBJC_ASSOCIATION_COPY_NONATOMIC) {
    Set<policy>(lv, rv);
    return;
  }

  if (SameOrEquals(lv, rv)) {
    return;
  }

  if (policy == OBJC_ASSOCIATION_RETAIN) {
    @synchronized(self) {
      lv = rv;
    }
  } else if (policy == OBJC_ASSOCIATION_COPY) {
    @synchronized(self) {
      lv = [rv copy];
    }
  }
}

}  // namespace objc
}  // namespace nd
#endif
