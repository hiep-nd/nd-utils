//
//  NDPossession.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDPossession<__covariant Owner : id <NSObject>> : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithOwner:(Owner)owner NS_DESIGNATED_INITIALIZER;
@property(nonatomic, weak, readonly) Owner owner;

@end

#ifdef __cplusplus
namespace nd {
namespace objc {
template <typename Owner>
inline Owner _Nullable ROwner(NDPossession* self) {
  return (Owner)self.owner;
}
}  // namespace objc
}  // namespace nd

#define NDPossession_ROwner_Default_Impl(Owner)       \
  namespace {                                         \
  inline Owner _Nullable ROwner(NDPossession* self) { \
    return nd::objc::ROwner<Owner>(self);             \
  }                                                   \
  }
#endif

NS_ASSUME_NONNULL_END
