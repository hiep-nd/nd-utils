//
//  UIViewController+NDUtils_SlideTransitioning.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIViewController+NDUtils_SlideTransitioning.h>

#import <NDUtils/NDViewControllerAnimatedTransitioning.h>
#import <NDUtils/NSNumber+NDUtils_UIKit.h>
#import <NDUtils/UIGestureRecognizer+NDUtils.h>
#import <NDUtils/UIViewController+NDUtils.h>

#import <NDUtils/CoreGraphics+NDUtils.h>
#import <NDUtils/Foundation+NDUtils.h>
#import <NDUtils/libextobjc+NDUtils.h>
#import <NDUtils/objc+NDUtils.h>

#import <map>

using namespace nd::objc;
using namespace std;

NDUIViewControllerSlideTransitioningOptionsKey const
    NDUIViewControllerSlideTransitioningOptionsKeyTransitionDuration =
        @"NDUIViewControllerSlideTransitioningOptionsKeyTransitionDuration";

NDUIViewControllerSlideTransitioningOptionsKey const
    NDUIViewControllerSlideTransitioningOptionsKeyDockingEdge =
        @"NDUIViewControllerSlideTransitioningOptionsKeyDockingEdge";

NDUIViewControllerSlideTransitioningOptionsKey const
    NDUIViewControllerSlideTransitioningOptionsKeyCoverAlpha =
        @"NDUIViewControllerSlideTransitioningOptionsKeyCoverAlpha";

NDUIViewControllerSlideTransitioningOptionsKey const
    NDUIViewControllerSlideTransitioningOptionsKeyPanPercentThreshold =
        @"NDUIViewControllerSlideTransitioningOptionsKeyPanPercentThreshold";

@implementation UIViewController (NDUtils_SlideTransitioning)

- (void)nd_enableSlideTransitioningWithOptions:
    (NSDictionary<NDUIViewControllerSlideTransitioningOptionsKey, id>*)options {
  // options
  auto transitionDuration =
      Get<NSNumber>(
          options,
          NDUIViewControllerSlideTransitioningOptionsKeyTransitionDuration,
          @(1.0 / 3))
          .nd_NSTimeIntervalValue;
  if (transitionDuration < 0) {
    NDDAssertionFailure(@"Invalid transition duration: '%g'.",
                        transitionDuration);
    transitionDuration = 1.0 / 3;
  }

  auto coverAlpha =
      Get<NSNumber>(options,
                    NDUIViewControllerSlideTransitioningOptionsKeyCoverAlpha,
                    @(0.4))
          .nd_CGFloatValue;
  if (coverAlpha < 0 || coverAlpha > 1) {
    NDDAssertionFailure(@"Invalid cover alpha: '%g'.", coverAlpha);
    coverAlpha = 0.4;
  }

  auto dockingEdge =
      Get<NSNumber>(options,
                    NDUIViewControllerSlideTransitioningOptionsKeyDockingEdge,
                    @(UIRectEdgeLeft))
          .nd_UIRectEdgeValue;
  if ((dockingEdge != UIRectEdgeLeft) && (dockingEdge != UIRectEdgeRight) &&
      (dockingEdge != UIRectEdgeTop) && (dockingEdge != UIRectEdgeBottom)) {
    NDDAssertionFailure(@"Invalid docking edge: '%lu'.",
                        (unsigned long)dockingEdge);
    dockingEdge = UIRectEdgeLeft;
  }

  auto percentThreshold =
      Get<NSNumber>(
          options,
          NDUIViewControllerSlideTransitioningOptionsKeyPanPercentThreshold,
          @(0.5))
          .nd_CGFloatValue;
  if (percentThreshold < 0 || percentThreshold > 1) {
    NDDAssertionFailure(@"Invalid percent threshold: '%g'.", percentThreshold);
    percentThreshold = 0.5;
  }

  auto hiddenFrame = [=](CGRect rect) {
    switch (dockingEdge) {
      case UIRectEdgeRight:
        return CGRectMake(rect.origin.x - rect.size.width, rect.origin.y,
                          rect.size.width, rect.size.height);
      case UIRectEdgeTop:
        return CGRectMake(rect.origin.x, rect.origin.y - rect.size.height,
                          rect.size.width, rect.size.height);
      case UIRectEdgeBottom:
        return CGRectMake(rect.origin.x, rect.origin.y + rect.size.height,
                          rect.size.width, rect.size.height);
      default:  // UIRectEdgeLeft
        return CGRectMake(rect.origin.x + rect.size.width, rect.origin.y,
                          rect.size.width, rect.size.height);
    }
  };

  // transition
  // delegate presented
  self.nd_transitioningDelegateHandlers
      .animationControllerForPresentedControllerPresentingControllerSourceController =
      ^id<UIViewControllerAnimatedTransitioning> _Nullable(
          UIViewController* _Nonnull presented,
          UIViewController* _Nonnull presenting,
          UIViewController* _Nonnull source) {
    auto controller = [[NDViewControllerAnimatedTransitioning alloc] init];
    controller.transitionDuration = ^NSTimeInterval(
        id<UIViewControllerContextTransitioning> _Nullable transitionContext) {
      return transitionDuration;
    };

    controller.animateTransition = ^(
        id<UIViewControllerContextTransitioning> _Nonnull transitionContext) {
      auto fromVC = [transitionContext
          viewControllerForKey:UITransitionContextFromViewControllerKey];
      auto toVC = [transitionContext
          viewControllerForKey:UITransitionContextToViewControllerKey];

      auto containerBounds = transitionContext.containerView.bounds;
      auto coverView = [[UIView alloc] initWithFrame:containerBounds];
      coverView.backgroundColor = UIColor.blackColor;
      coverView.alpha = 0;

      [transitionContext.containerView insertSubview:coverView
                                        aboveSubview:fromVC.view];
      [transitionContext.containerView insertSubview:toVC.view
                                        aboveSubview:coverView];

      toVC.view.frame = hiddenFrame(containerBounds);
      [UIView animateWithDuration:transitionDuration
          animations:^{
            toVC.view.frame = containerBounds;
            coverView.alpha = coverAlpha;
          }
          completion:^(BOOL) {
            [transitionContext
                completeTransition:!transitionContext.transitionWasCancelled];
            [coverView removeFromSuperview];
          }];
    };

    return controller;
  };

  // dismissed
  self.nd_transitioningDelegateHandlers
      .animationControllerForDismissedController =
      ^id<UIViewControllerAnimatedTransitioning> _Nullable(
          UIViewController* _Nonnull dismissed) {
    auto controller = [[NDViewControllerAnimatedTransitioning alloc] init];
    controller.transitionDuration = ^NSTimeInterval(
        id<UIViewControllerContextTransitioning> _Nullable transitionContext) {
      return transitionDuration;
    };

    controller.animateTransition = ^(
        id<UIViewControllerContextTransitioning> transitionContext) {
      auto fromVC = [transitionContext
          viewControllerForKey:UITransitionContextFromViewControllerKey];
      auto toVC = [transitionContext
          viewControllerForKey:UITransitionContextToViewControllerKey];
      auto containerBounds = transitionContext.containerView.bounds;
      auto coverView = [[UIView alloc] initWithFrame:containerBounds];
      coverView.backgroundColor = UIColor.blackColor;
      coverView.alpha = coverAlpha;

      [transitionContext.containerView insertSubview:coverView
                                        belowSubview:fromVC.view];
      [transitionContext.containerView insertSubview:toVC.view
                                        belowSubview:coverView];
      [UIView animateWithDuration:transitionDuration
          animations:^{
            fromVC.view.frame = hiddenFrame(containerBounds);
            coverView.alpha = 0;
          }
          completion:^(BOOL) {
            [transitionContext
                completeTransition:!transitionContext.transitionWasCancelled];
            [coverView removeFromSuperview];
          }];
    };

    return controller;
  };

  // interaction
  // controller
  auto interactionController =
      [[UIPercentDrivenInteractiveTransition alloc] init];
  __block auto hasStarted = NO;
  __block auto shouldFinish = NO;
  auto finishInteractiveTransition = ^{
    [interactionController finishInteractiveTransition];
    hasStarted = NO;
    shouldFinish = NO;
  };
  auto cancelInteractiveTransition = ^{
    [interactionController cancelInteractiveTransition];
    hasStarted = NO;
    shouldFinish = NO;
  };

  self.nd_transitioningDelegateHandlers.interactionControllerForDismissal =
      ^id<UIViewControllerInteractiveTransitioning> _Nullable(
          id<UIViewControllerAnimatedTransitioning> _Nonnull animator) {
    return hasStarted ? interactionController : nil;
  };

  // gesture recognizer
  auto panGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] init];
  panGestureRecognizer.edges = dockingEdge;

  @weakify(self);
  [panGestureRecognizer
      nd_addAction:^(UIScreenEdgePanGestureRecognizer* sender) {
        @strongify(self);
        // convert position to pull progress (percentage)
        auto translation = [sender translationInView:sender.view];
        auto edges = sender.edges;
        auto bounds = sender.view.bounds;
        CGFloat progress;
        if (edges == UIRectEdgeRight) {
          progress = -translation.x / bounds.size.width;
        } else if (edges == UIRectEdgeTop) {
          progress = translation.y / bounds.size.height;
        } else if (edges == UIRectEdgeBottom) {
          progress = -translation.y / bounds.size.height;
        } else {
          progress = translation.x / bounds.size.width;
        }
        progress = min(max(progress, CGFloat(0)), CGFloat(1));

        switch (sender.state) {
          case UIGestureRecognizerStateBegan:
            hasStarted = YES;
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
          case UIGestureRecognizerStateChanged:
            shouldFinish = progress > percentThreshold;
            [interactionController updateInteractiveTransition:progress];
            break;
          case UIGestureRecognizerStateCancelled:
            hasStarted = YES;
            cancelInteractiveTransition();
            break;
          case UIGestureRecognizerStateEnded:
            hasStarted = YES;
            if (shouldFinish) {
              finishInteractiveTransition();
            } else {
              cancelInteractiveTransition();
            }
            break;
          default:
            break;
        }
      }];
  [self.view addGestureRecognizer:panGestureRecognizer];
  SetAssociatedObject<OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
      self, @selector(nd_enableSlideTransitioningWithOptions:),
      panGestureRecognizer);
}

- (void)nd_disableSlideTransitioning {
  self.nd_transitioningDelegateHandlers
      .animationControllerForPresentedControllerPresentingControllerSourceController =
      nil;
  self.nd_transitioningDelegateHandlers
      .animationControllerForDismissedController = nil;
  self.nd_transitioningDelegateHandlers.interactionControllerForDismissal = nil;

  auto panGestureRecognizer =
      PeekAssociatedObject<UIScreenEdgePanGestureRecognizer*>(
          self, @selector(nd_enableSlideTransitioningWithOptions:));
  if (panGestureRecognizer) {
    [self.view removeGestureRecognizer:panGestureRecognizer];
    SetAssociatedObject<OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
        self, @selector(nd_enableSlideTransitioningWithOptions:), nil);
  }
}

@end
