//
//  UITextView+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIScrollView+NDUtils.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDUIUITextViewDelegateHandlers : NDUIScrollViewDelegateHandlers

/// became first responder
@property(nonatomic, copy) void (^_Nullable didBeginEditing)
    (__kindof UITextView*);

@end

@interface UITextView (NDUtils)

@property(nonatomic, strong, readonly)
    NDUIUITextViewDelegateHandlers* nd_delegateHandlers;

@end

NS_ASSUME_NONNULL_END
