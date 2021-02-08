//
//  UIViewController+NDUtils_PanDownToDismiss.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIViewController+NDUtils_PanDownToDismiss.h>

#import <NDUtils/NDViewControllerAnimatedTransitioning.h>
#import <NDUtils/NSNumber+NDUtils_UIKit.h>
#import <NDUtils/UIGestureRecognizer+NDUtils.h>
#import <NDUtils/UIViewController+NDUtils.h>

#import <NDUtils/CoreGraphics+NDUtils.h>
#import <NDUtils/Foundation+NDUtils.h>
#import <NDUtils/libextobjc+NDUtils.h>
#import <NDUtils/objc+NDUtils.h>

using namespace nd::objc;

NDUIViewControllerPanDownToDismissOptionsKey const
    NDUIViewControllerPanDownToDismissOptionsKeyScrollView =
        @"NDUIViewControllerPanDownToDismissOptionsKeyScrollView";
NDUIViewControllerPanDownToDismissOptionsKey const
    NDUIViewControllerPanDownToDismissOptionsKeyTransitionDuration =
        @"NDUIViewControllerPanDownToDismissOptionsKeyTransitionDuration";
NDUIViewControllerPanDownToDismissOptionsKey const
    NDUIViewControllerPanDownToDismissOptionsKeyPercentThreshold =
        @"NDUIViewControllerPanDownToDismissOptionsKeyPercentThreshold";

@implementation UIViewController (NDUtils_PanDownToDismiss)

- (void)nd_enablePanDownToDismissWithOptions:
    (NSDictionary<NDUIViewControllerPanDownToDismissOptionsKey, id>*)options {
  // options
  auto const scrollView = Get<UIScrollView>(
      options, NDUIViewControllerPanDownToDismissOptionsKeyScrollView, nil);

  auto transitionDuration =
      Get<NSNumber>(
          options,
          NDUIViewControllerPanDownToDismissOptionsKeyTransitionDuration,
          @(0.6))
          .nd_NSTimeIntervalValue;
  if (transitionDuration < 0) {
    NDDAssertionFailure(@"Invalid transition duration: '%g'.",
                        transitionDuration);
    transitionDuration = 0.5;
  }

  auto percentThreshold =
      Get<NSNumber>(
          options, NDUIViewControllerPanDownToDismissOptionsKeyPercentThreshold,
          @(0.5))
          .nd_CGFloatValue;
  if (percentThreshold < 0 || percentThreshold > 1) {
    NDDAssertionFailure(@"Invalid percent threshold: '%g'.", percentThreshold);
    percentThreshold = 0.5;
  }

  // transition
  // delegate presented
  self.nd_transitioningDelegateHandlers
      .animationControllerForDismissedController =
      ^id<UIViewControllerAnimatedTransitioning>(UIViewController* dismissed) {
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

      [transitionContext.containerView insertSubview:toVC.view
                                        belowSubview:fromVC.view];

      auto screenBounds = UIScreen.mainScreen.bounds;
      auto bottomLeftCorner = CGPointMake(0, screenBounds.size.height);
      auto finalFrame =
          CGRectMake(bottomLeftCorner.x, bottomLeftCorner.y,
                     screenBounds.size.width, screenBounds.size.height);

      [UIView animateWithDuration:transitionDuration
          animations:^{
            fromVC.view.frame = finalFrame;
          }
          completion:^(BOOL) {
            [transitionContext
                completeTransition:!transitionContext.transitionWasCancelled];
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
  auto panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
  @weakify(self);
  [panGestureRecognizer nd_addAction:^(UIPanGestureRecognizer* sender) {
    @strongify(self);
    // convert y-position to downward pull progress (percentage)
    auto translation = [sender translationInView:self.view];
    auto verticalMovement = translation.y / self.view.bounds.size.height;
    auto downwardMovement = fmaxf(verticalMovement, 0.0);
    auto downwardMovementPercent = fminf(downwardMovement, 1.0);
    auto progress = (CGFloat)downwardMovementPercent;

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

  @weakify(scrollView);
  panGestureRecognizer.nd_delegateHandlers.shouldBegin =
      ^BOOL(UIPanGestureRecognizer* sender) {
        @strongify(self, scrollView);
        auto translation = [sender translationInView:self.view];
        return (abs(translation.x) < translation.y) &&
               ((scrollView == nil) ||
                (scrollView.contentOffset.y <= -scrollView.contentInset.top));
      };

  panGestureRecognizer.nd_delegateHandlers
      .shouldRecognizeSimultaneouslyWithGestureRecognizer =
      ^BOOL(__kindof UIGestureRecognizer* _Nonnull,
            UIGestureRecognizer* _Nonnull otherGestureRecognizer) {
        return YES;
      };

  [(scrollView ?: self.view) addGestureRecognizer:panGestureRecognizer];
  SetAssociatedObject<OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
      self, @selector(nd_enablePanDownToDismissWithOptions:),
      panGestureRecognizer);
}

- (void)nd_disablePanDownToDismiss {
  self.nd_transitioningDelegateHandlers
      .animationControllerForDismissedController = nil;
  self.nd_transitioningDelegateHandlers.interactionControllerForDismissal = nil;

  auto panGestureRecognizer = PeekAssociatedObject<UIPanGestureRecognizer*>(
      self, @selector(nd_enablePanDownToDismissWithOptions:));
  if (panGestureRecognizer) {
    [panGestureRecognizer.view removeGestureRecognizer:panGestureRecognizer];
    SetAssociatedObject<OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
        self, @selector(nd_enablePanDownToDismissWithOptions:), nil);
  }
}

@end
