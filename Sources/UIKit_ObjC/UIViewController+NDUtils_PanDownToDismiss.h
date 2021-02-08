//
//  UIViewController+NDUtils_PanDownToDismiss.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString* NDUIViewControllerPanDownToDismissOptionsKey
    NS_TYPED_EXTENSIBLE_ENUM;

/// UIScrollView
UIKIT_EXTERN NDUIViewControllerPanDownToDismissOptionsKey const
    NDUIViewControllerPanDownToDismissOptionsKeyScrollView
        NS_SWIFT_NAME(scrollView);

/// Time interval, 0..
UIKIT_EXTERN NDUIViewControllerPanDownToDismissOptionsKey const
    NDUIViewControllerPanDownToDismissOptionsKeyTransitionDuration
        NS_SWIFT_NAME(transitionDuration);

/// CGFloat, 0..1
UIKIT_EXTERN NDUIViewControllerPanDownToDismissOptionsKey const
    NDUIViewControllerPanDownToDismissOptionsKeyPercentThreshold
        NS_SWIFT_NAME(percentThreshold);

@interface UIViewController (NDUtils_PanDownToDismiss)

- (void)nd_enablePanDownToDismissWithOptions:
    (NSDictionary<NDUIViewControllerPanDownToDismissOptionsKey, id>* _Nullable)
        options NS_REFINED_FOR_SWIFT;
- (void)nd_disablePanDownToDismiss;

@end

NS_ASSUME_NONNULL_END
