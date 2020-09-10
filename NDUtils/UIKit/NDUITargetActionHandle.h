//
//  NDUITargetActionHandle.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NDPossession.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDUITargetActionHandle<__covariant Owner : id <NSObject>>
    : NDPossession <Owner>

- (instancetype)initWithOwner:(Owner)owner NS_UNAVAILABLE;
- (instancetype)initWithOwner:(Owner)owner
                       action:(void (^)(__kindof Owner, UIEvent*))action
    NS_DESIGNATED_INITIALIZER;

@property(nonatomic, copy) void (^action)(__kindof Owner, UIEvent*);
- (void)actionWithSender:(Owner)sender event:(UIEvent*)event;

@end

NS_ASSUME_NONNULL_END
