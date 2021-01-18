//
//  UIViewController+NDUtils_SlideTransitioning.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString* NDUIViewControllerSlideTransitioningOptionsKey
    NS_TYPED_EXTENSIBLE_ENUM;

/// Time interval, 0..
UIKIT_EXTERN NDUIViewControllerSlideTransitioningOptionsKey const
    NDUIViewControllerSlideTransitioningOptionsKeyTransitionDuration
        NS_SWIFT_NAME(transitionDuration);

/// CGFloat, 0..1
UIKIT_EXTERN NDUIViewControllerSlideTransitioningOptionsKey const
    NDUIViewControllerSlideTransitioningOptionsKeyCoverAlpha
        NS_SWIFT_NAME(coverAlpha);

/// UIRectEdge
UIKIT_EXTERN NDUIViewControllerSlideTransitioningOptionsKey const
    NDUIViewControllerSlideTransitioningOptionsKeyDockingEdge
        NS_SWIFT_NAME(dockingEdge);

/// CGFloat, 0..1
UIKIT_EXTERN NDUIViewControllerSlideTransitioningOptionsKey const
    NDUIViewControllerSlideTransitioningOptionsKeyPanPercentThreshold
        NS_SWIFT_NAME(panPercentThreshold);

@interface UIViewController (NDUtils_SlideTransitioning)

- (void)nd_enableSlideTransitioningWithOptions:
    (NSDictionary<NDUIViewControllerSlideTransitioningOptionsKey,
                  id>* _Nullable)options NS_REFINED_FOR_SWIFT;

- (void)nd_disableSlideTransitioning;

@end

NS_ASSUME_NONNULL_END
