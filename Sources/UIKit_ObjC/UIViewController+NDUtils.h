//
//  UIViewController+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 21/12/2020.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NDUtils/NDPossession.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NDUIViewControllerTransitioningDelegateHandlesProtocol)
@protocol NDUIViewControllerTransitioningDelegateHandles <
    UIViewControllerTransitioningDelegate>

@property(nonatomic, copy) id<UIViewControllerAnimatedTransitioning> _Nullable (
    ^_Nullable animationControllerForPresentedControllerPresentingControllerSourceController)
    (UIViewController* presented,
     UIViewController* presenting,
     UIViewController* source);

@property(nonatomic, copy) id<UIViewControllerAnimatedTransitioning> _Nullable (
    ^_Nullable animationControllerForDismissedController)
    (UIViewController* dismissed);

@property(nonatomic, copy)
    id<UIViewControllerInteractiveTransitioning> _Nullable (
        ^_Nullable interactionControllerForPresentation)
        (id<UIViewControllerAnimatedTransitioning> animator);

@property(nonatomic, copy)
    id<UIViewControllerInteractiveTransitioning> _Nullable (
        ^_Nullable interactionControllerForDismissal)
        (id<UIViewControllerAnimatedTransitioning> animator);

@property(nonatomic, copy) UIPresentationController* _Nullable (
    ^_Nullable presentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController)
    (UIViewController* presented,
     UIViewController* _Nullable presenting,
     UIViewController* source) API_AVAILABLE(ios(8.0));

@end

// clang-format off
@interface NDUIViewControllerTransitioningDelegateHandles
    : NDPossession <UIViewController*>
      <NDUIViewControllerTransitioningDelegateHandles>
    // clang-format on

    @end

@interface UIViewController (NDUtils)

@property(nonatomic, strong, readonly)
    __kindof id<NDUIViewControllerTransitioningDelegateHandles>
        nd_transitioningDelegateHandlers;
@property(nonatomic, readonly)
    UIViewController* _Nullable nd_topPresentedViewController;
@property(nonatomic, readonly)
    UIViewController* _Nullable nd_bottomPresentingViewController;

/// Dismiss this view controller.
/// @param animated The animated.
/// @param completion The completion.
- (void)nd_dismissWithAnimated:(BOOL)animated
                    completion:(void (^_Nullable)(void))completion
    NS_REFINED_FOR_SWIFT;

@end

NS_ASSUME_NONNULL_END
