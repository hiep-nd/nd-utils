//
//  UIViewController+NDUtils_PanDownToDismiss.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIKit/UIViewController+NDUtils_PanDownToDismiss.h>

#import <NDLog/NDLog.h>
#import <NDUtils/Foundation/NDMacros.h>
#import <NDUtils/objc/NDPossession.h>
#import <NDUtils/objc/runtime+NDUtils.h>

using namespace nd;

@interface NDUIViewControllerPanDownToDismissInteractionController
    : UIPercentDrivenInteractiveTransition

@property(nonatomic, assign) BOOL hasStarted;
@property(nonatomic, assign) BOOL shouldFinish;
@property(nonatomic, copy) void (^_Nullable didFinishInteractiveTransition)
    (void);

@end

@interface NDUIViewControllerPanDownToDismissHelper
    : NDPossession <UIViewController*>
<UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate>

    - (instancetype)initWithOwner : (UIViewController*)owner NS_UNAVAILABLE;
- (instancetype)initWithOwner:(UIViewController*)owner
                   scrollView:(UIScrollView* _Nullable)scrollView
    NS_DESIGNATED_INITIALIZER;

@property(nonatomic, strong, readonly)
    UIPanGestureRecognizer* panGestureRecognizer;
@property(nonatomic, strong, readonly)
    NDUIViewControllerPanDownToDismissInteractionController*
        interactionController;
@property(nonatomic, weak, readonly) UIScrollView* scrollView;

@end

@interface NDUIViewControllerPanDownToDismissAnimationController
    : NSObject <UIViewControllerAnimatedTransitioning>
@end

@implementation NDUIViewControllerPanDownToDismissAnimationController

- (NSTimeInterval)transitionDuration:
    (id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.6;
}

- (void)animateTransition:
    (id<UIViewControllerContextTransitioning>)transitionContext {
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

  [UIView animateWithDuration:[self transitionDuration:transitionContext]
      animations:^{
        fromVC.view.frame = finalFrame;
      }
      completion:^(BOOL) {
        [transitionContext
            completeTransition:!transitionContext.transitionWasCancelled];
      }];
}

@end

@implementation NDUIViewControllerPanDownToDismissInteractionController

- (void)finishInteractiveTransition {
  [super finishInteractiveTransition];
  NDCallAndReturnIfCan(self.didFinishInteractiveTransition);
}

@end

@implementation NDUIViewControllerPanDownToDismissHelper

- (instancetype)initWithOwner:(UIViewController*)owner
                   scrollView:(UIScrollView*)scrollView {
  self = [super initWithOwner:owner];
  if (self) {
    owner.transitioningDelegate = self;

    _panGestureRecognizer = [[UIPanGestureRecognizer alloc]
        initWithTarget:self
                action:@selector(panGestureRecognizerAction)];
    _panGestureRecognizer.delegate = self;

    if (scrollView) {
      [scrollView addGestureRecognizer:_panGestureRecognizer];
      _scrollView = scrollView;
    } else {
      [owner.view addGestureRecognizer:_panGestureRecognizer];
    }

    _interactionController =
        [[NDUIViewControllerPanDownToDismissInteractionController alloc] init];
  }
  return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
  auto translation = [_panGestureRecognizer translationInView:self.owner.view];
  return (abs(translation.x) < translation.y) &&
         ((_scrollView == nil) ||
          (_scrollView.contentOffset.y <= -_scrollView.contentInset.top));
}

// MARK: - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForDismissedController:(UIViewController*)dismissed {
  return [[NDUIViewControllerPanDownToDismissAnimationController alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)
    interactionControllerForDismissal:
        (id<UIViewControllerAnimatedTransitioning>)animator {
  return _interactionController.hasStarted ? _interactionController : nil;
}

- (IBAction)panGestureRecognizerAction {
  auto percentThreshold = 0.5;

  // convert y-position to downward pull progress (percentage)
  auto translation = [_panGestureRecognizer translationInView:self.owner.view];
  auto verticalMovement = translation.y / self.owner.view.bounds.size.height;
  auto downwardMovement = fmaxf(verticalMovement, 0.0);
  auto downwardMovementPercent = fminf(downwardMovement, 1.0);
  auto progress = (CGFloat)downwardMovementPercent;

  switch (_panGestureRecognizer.state) {
    case UIGestureRecognizerStateBegan:
      _interactionController.hasStarted = YES;
      [self.owner dismissViewControllerAnimated:YES completion:nil];
      break;
    case UIGestureRecognizerStateChanged:
      _interactionController.shouldFinish = progress > percentThreshold;
      [_interactionController updateInteractiveTransition:progress];
      break;
    case UIGestureRecognizerStateCancelled:
      _interactionController.hasStarted = YES;
      [_interactionController cancelInteractiveTransition];
      break;
    case UIGestureRecognizerStateEnded:
      _interactionController.hasStarted = YES;
      if (_interactionController.shouldFinish) {
        [_interactionController finishInteractiveTransition];
      } else {
        [_interactionController cancelInteractiveTransition];
      }
      break;
    default:
      break;
  }
}

@end

@implementation UIViewController (NDUtils_PanDownToDismiss)

- (NDUIViewControllerPanDownToDismissHelper*)nd_panDownToDismissHelper {
  return PeekAssociatedObject<NDUIViewControllerPanDownToDismissHelper*>(
      self, @selector(nd_panDownToDismissHelper));
}

- (void)setNd_panDownToDismissHelper:
    (NDUIViewControllerPanDownToDismissHelper*)nd_panDownToDismissHelper {
  return SetAssociatedObject<OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
      self, @selector(nd_panDownToDismissHelper), nd_panDownToDismissHelper);
}

- (BOOL)nd_panDownToDismiss {
  auto helper = self.nd_panDownToDismissHelper;
  return helper && (self.transitioningDelegate == helper);
}

- (void)nd_enablePanDownToDismissWithScrollView:(UIScrollView*)scrollView
                 didFinishInteractiveTransition:
                     (void (^)(void))didFinishInteractiveTransition {
  self.nd_panDownToDismissHelper =
      [[NDUIViewControllerPanDownToDismissHelper alloc]
          initWithOwner:self
             scrollView:scrollView];
  self.nd_panDownToDismissHelper.interactionController
      .didFinishInteractiveTransition = didFinishInteractiveTransition;
}

- (void)nd_disablePanDownToDismiss {
  self.nd_panDownToDismissHelper = nil;
}

@end
