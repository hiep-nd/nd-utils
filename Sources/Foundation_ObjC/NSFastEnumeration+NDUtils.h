//
//  NSFastEnumeration+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
#import <initializer_list>
#import <utility>
#endif

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

inline NSMutableArray* Filter(id<NSFastEnumeration> container,
                              BOOL (^isIncluded)(id)) {
  if (!isIncluded) {
    return nil;
  }

  auto builder = [[NSMutableArray alloc] init];
  for (__unsafe_unretained id obj in container) {
    if (isIncluded(obj)) {
      [builder addObject:obj];
    }
  }
  return builder;
}

inline NSMutableArray* SafeNSMutableArray(std::initializer_list<id> objs) {
  auto builder = [[NSMutableArray alloc] initWithCapacity:objs.size()];
  for (auto& obj : objs) {
    if (obj) {
      [builder addObject:obj];
    }
  }
  return builder;
}

inline NSMutableDictionary* SafeNSMutableDictionary(
    std::initializer_list<std::pair<id, id>> pairs) {
  auto builder = [[NSMutableDictionary alloc] init];
  for (auto& p : pairs) {
    if (p.first) {
      builder[p.first] = p.second;
    }
  }
  return builder;
}
}
}
#endif

NS_ASSUME_NONNULL_END
