//
//  CATransaction+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT
void NDAttachToAnimationCompletion(void(NS_NOESCAPE ^ animation)(void),
                                   void (^completion)(void))
    NS_SWIFT_NAME(nd_attach(toAnimation:completion:));

#ifdef __cplusplus
namespace nd {
template <typename T>
inline T attachToAnimation(T(NS_NOESCAPE ^ _Nonnull animation)(void),
                           void (^completion)(void)) {
  __block T result;
  NDAttachToAnimationCompletion(
      ^{
        if (animation) {
          result = animation();
        }
      },
      completion);
  return result;
}
}
#endif

NS_ASSUME_NONNULL_END
