//
//  NDEvent.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/3/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NDPossession.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NDEventProtocol)
@protocol NDEvent <NSObject>

- (void)on;

@end

@interface NDEvent<__covariant Owner : id <NSObject>> : NDPossession <Owner>
<NDEvent>

    // clang-format off
@property(nonatomic, copy) void (^_Nullable handler)(Owner owner);
// clang-format on

- (void)addHandler:(void (^)(Owner owner))handler;
- (void)updateHandler:(void (^_Nullable)(void (^_Nullable oldHandler)(Owner),
                                         Owner owner))handler;
+ (instancetype)eventWithOwner:(Owner)owner
                       handler:(void (^_Nullable)(Owner))handler;

@end

NS_ASSUME_NONNULL_END
