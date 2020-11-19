//
//  UITextField+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NDUtils/NDPossession.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDUITextFieldDelegateHandlers : NDPossession <UITextField*>

/// became first responder
@property(nonatomic, copy) void (^_Nullable didBeginEditing)
    (__kindof UITextField*);

/// called when 'return' key pressed. return NO to ignore.
@property(nonatomic, copy) BOOL (^_Nullable shouldReturn)(__kindof UITextField*)
    ;

@end

@interface UITextField (NDUtils)

@property(nonatomic, strong, readonly)
    NDUITextFieldDelegateHandlers* nd_delegateHandlers;

@end

NS_ASSUME_NONNULL_END
