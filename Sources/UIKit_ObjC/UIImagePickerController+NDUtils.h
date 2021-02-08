//
//  UIImagePickerController+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UINavigationController+NDUtils.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDUIImagePickerControllerDelegateHandlers
    : NDUINavigationControllerDelegateHandlers <UIImagePickerControllerDelegate>

// The picker does not dismiss itself; the client dismisses it in these
// callbacks. The delegate will receive one or the other, but not both,
// depending whether the user confirms or cancels.
@property(nonatomic, copy) void (^_Nullable didFinishPickingMediaWithInfo)
    (__kindof UIImagePickerController*,
     NSDictionary<UIImagePickerControllerInfoKey, id>*);
@property(nonatomic, copy) void (^_Nullable didCancel)
    (__kindof UIImagePickerController*);

@end

@interface UIImagePickerController (NDUtils)

@property(nonatomic, strong, readonly)
    NDUIImagePickerControllerDelegateHandlers* nd_delegateHandlers;

@end

NS_ASSUME_NONNULL_END
