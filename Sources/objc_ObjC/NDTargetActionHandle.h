//
//  NDTargetActionHandle.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NDPossession.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDAbstractBaseTargetActionHandle<__covariant Owner : id <NSObject>>
    : NDPossession <Owner>

- (void)disconnectWithOwner;

@end

@interface NDAbstractTargetActionHandle0<__covariant Owner : id <NSObject>,
                                         __covariant Sender : id <NSObject>>
    : NDAbstractBaseTargetActionHandle <Owner>

- (instancetype)initWithOwner:(Owner)owner NS_UNAVAILABLE;
- (instancetype)initWithOwner:(Owner)owner
                       action:(void (^)(__kindof Sender))action
    NS_DESIGNATED_INITIALIZER;

@property(nonatomic, copy) void (^_Nullable action)(__kindof Sender);
- (void)actionWithSender:(__kindof Sender)sender;

@end

@interface NDAbstractTargetActionHandle1<__covariant Owner : id <NSObject>,
                                         __covariant Sender : id <NSObject>,
                                         __covariant Para : id <NSObject>>
    : NDAbstractBaseTargetActionHandle <Owner>

- (instancetype)initWithOwner:(Owner)owner NS_UNAVAILABLE;
- (instancetype)initWithOwner:(Owner)owner
                       action:(void (^)(__kindof Sender, __kindof Para))action
    NS_DESIGNATED_INITIALIZER;

@property(nonatomic, copy) void (^_Nullable action)
    (__kindof Sender, __kindof Para);
- (void)actionWithSender:(__kindof Sender)sender para:(__kindof Para)para;

@end

@interface NDAbstractTargetActionHandle2<__covariant Owner : id <NSObject>,
                                         __covariant Sender : id <NSObject>,
                                         __covariant Para0 : id <NSObject>,
                                         __covariant Para1 : id <NSObject>>
    : NDAbstractBaseTargetActionHandle <Owner>

- (instancetype)initWithOwner:(Owner)owner NS_UNAVAILABLE;
- (instancetype)initWithOwner:(Owner)owner
                       action:(void (^)(__kindof Sender,
                                        __kindof Para0,
                                        __kindof Para1))action
    NS_DESIGNATED_INITIALIZER;

@property(nonatomic, copy) void (^_Nullable action)
    (__kindof Sender, __kindof Para0, __kindof Para1);
- (void)actionWithSender:(__kindof Sender)sender
                   para0:(__kindof Para0)para0
                   para1:(__kindof Para1)para1;

@end

@interface NDAbstractTargetActionHandle3<__covariant Owner : id <NSObject>,
                                         __covariant Sender : id <NSObject>,
                                         __covariant Para0 : id <NSObject>,
                                         __covariant Para1 : id <NSObject>,
                                         __covariant Para2 : id <NSObject>>
    : NDAbstractBaseTargetActionHandle <Owner>

- (instancetype)initWithOwner:(Owner)owner NS_UNAVAILABLE;
- (instancetype)initWithOwner:(Owner)owner
                       action:(void (^)(__kindof Sender,
                                        __kindof Para0,
                                        __kindof Para1,
                                        __kindof Para2))action
    NS_DESIGNATED_INITIALIZER;

@property(nonatomic, copy) void (^_Nullable action)
    (__kindof Sender, __kindof Para0, __kindof Para1, __kindof Para2);
- (void)actionWithSender:(__kindof Sender)sender
                   para0:(__kindof Para0)para0
                   para1:(__kindof Para1)para1
                   para2:(__kindof Para2)para2;

@end

NS_ASSUME_NONNULL_END
