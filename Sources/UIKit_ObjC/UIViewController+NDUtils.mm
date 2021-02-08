//
//  UIViewController+NDUtils.m
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 21/12/2020.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIViewController+NDUtils.h>

#import <NDUtils/NDMacros+NDUtils.h>
#import <NDUtils/runtime+NDUtils.h>

#import <NDLog/NDLog.h>

#import <map>

using namespace nd::objc;
using namespace std;

@implementation NDUIViewControllerTransitioningDelegateHandles

namespace {
template <typename T>
void Set(NDUIViewControllerTransitioningDelegateHandles* self, T& lv, T rv) {
  nd::objc::Set<OBJC_ASSOCIATION_COPY_NONATOMIC>(self, lv, rv);
  self.owner.transitioningDelegate = nil;
  self.owner.transitioningDelegate = self;
}
}

- (instancetype)initWithOwner:(UIViewController*)owner {
  self = [super initWithOwner:owner];
  if (self) {
    owner.transitioningDelegate = self;
  }
  return self;
}

// MARK: - NDUIViewControllerTransitioningDelegateHandles

@synthesize animationControllerForDismissedController =
    _animationControllerForDismissedController;
- (void)setAnimationControllerForDismissedController:
    (id<UIViewControllerAnimatedTransitioning> _Nullable (^)(
        UIViewController* _Nonnull))animationControllerForDismissedController {
  Set(self, _animationControllerForDismissedController,
      animationControllerForDismissedController);
}

@synthesize
    animationControllerForPresentedControllerPresentingControllerSourceController =
        _animationControllerForPresentedControllerPresentingControllerSourceController;
- (void)setAnimationControllerForPresentedControllerPresentingControllerSourceController:
    (id<UIViewControllerAnimatedTransitioning> _Nullable (^)(
        UIViewController* _Nonnull,
        UIViewController* _Nonnull,
        UIViewController* _Nonnull))
        animationControllerForPresentedControllerPresentingControllerSourceController {
  Set(self,
      _animationControllerForPresentedControllerPresentingControllerSourceController,
      animationControllerForPresentedControllerPresentingControllerSourceController);
}

@synthesize interactionControllerForDismissal =
    _interactionControllerForDismissal;
- (void)setInteractionControllerForDismissal:
    (id<UIViewControllerInteractiveTransitioning> _Nullable (^)(
        id<UIViewControllerAnimatedTransitioning> _Nonnull))
        interactionControllerForDismissal {
  Set(self, _interactionControllerForDismissal,
      interactionControllerForDismissal);
}

@synthesize interactionControllerForPresentation =
    _interactionControllerForPresentation;
- (void)setInteractionControllerForPresentation:
    (id<UIViewControllerInteractiveTransitioning> _Nullable (^)(
        id<UIViewControllerAnimatedTransitioning> _Nonnull))
        interactionControllerForPresentation {
  Set(self, _interactionControllerForPresentation,
      interactionControllerForPresentation);
}

@synthesize
    presentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController =
        _presentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController;
- (void)setPresentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController:
    (UIPresentationController* _Nullable (^)(UIViewController* _Nonnull,
                                             UIViewController* _Nullable,
                                             UIViewController* _Nonnull))
        presentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController {
  Set(self,
      _presentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController,
      presentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController);
}

// MARK:- UIViewControllerTransitioningDelegate - optionals
- (nullable id<UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController*)presented
                         presentingController:(UIViewController*)presenting
                             sourceController:(UIViewController*)source {
  NDCallAndReturnIfCan(
      self.animationControllerForPresentedControllerPresentingControllerSourceController,
      presented, presenting, source);

  NDAssertionFailure(
      @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
      NSStringFromSelector(@selector(
          animationControllerForPresentedControllerPresentingControllerSourceController
          )));

  return nil;
}

- (nullable id<UIViewControllerAnimatedTransitioning>)
    animationControllerForDismissedController:(UIViewController*)dismissed {
  NDCallAndReturnIfCan(self.animationControllerForDismissedController,
                       dismissed);
  NDAssertionFailure(
      @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
      NSStringFromSelector(@selector
                           (animationControllerForDismissedController)));
  return nil;
}

- (nullable id<UIViewControllerInteractiveTransitioning>)
    interactionControllerForPresentation:
        (id<UIViewControllerAnimatedTransitioning>)animator {
  NDCallAndReturnIfCan(self.interactionControllerForPresentation, animator);
  NDAssertionFailure(
      @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
      NSStringFromSelector(@selector(interactionControllerForPresentation)));

  return nil;
}

- (nullable id<UIViewControllerInteractiveTransitioning>)
    interactionControllerForDismissal:
        (id<UIViewControllerAnimatedTransitioning>)animator {
  NDCallAndReturnIfCan(self.interactionControllerForDismissal, animator);
  NDAssertionFailure(
      @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
      NSStringFromSelector(@selector(interactionControllerForDismissal)));

  return nil;
}

- (nullable UIPresentationController*)
    presentationControllerForPresentedViewController:
        (UIViewController*)presented
                            presentingViewController:
                                (nullable UIViewController*)presenting
                                sourceViewController:(UIViewController*)source {
  NDCallAndReturnIfCan(

      self.presentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController,
      presented, presenting, source);
  NDAssertionFailure(
      @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
      NSStringFromSelector(@selector(
          presentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController
          )));

  return nil;
}

// MARK:- NSObject
- (BOOL)respondsToSelector:(SEL)aSelector {
  // clang-format off
  static auto selectorsMap = ([]() {
    auto builder = map<SEL, BOOL (^)(NDUIViewControllerTransitioningDelegateHandles*)>({
      {
        @selector(animationControllerForPresentedController:presentingController:sourceController:),
        ^BOOL(NDUIViewControllerTransitioningDelegateHandles* self) {
          return self.animationControllerForPresentedControllerPresentingControllerSourceController != nil;
        }
      },
      {
        @selector(animationControllerForDismissedController:),
        ^BOOL(NDUIViewControllerTransitioningDelegateHandles* self) {
          return self.animationControllerForDismissedController != nil;
        }
      },
      {
        @selector(interactionControllerForPresentation:),
        ^BOOL(NDUIViewControllerTransitioningDelegateHandles* self) {
          return self.interactionControllerForPresentation != nil;
        }
      },
      {
        @selector(interactionControllerForDismissal:),
        ^BOOL(NDUIViewControllerTransitioningDelegateHandles* self) {
          return self.interactionControllerForDismissal != nil;
        }
      },
      {
        @selector(presentationControllerForPresentedViewController:presentingViewController:sourceViewController:),
        ^BOOL(NDUIViewControllerTransitioningDelegateHandles* self) {
          return self.presentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController != nil;
        }
      },
    });

    return builder;
  })();

  auto it = selectorsMap.find(aSelector);
  if (it != selectorsMap.end()) {
    return it->second(self);
  }

  return [super respondsToSelector:aSelector];
// clang-format on
}

@end

@implementation UIViewController (NDUtils)

namespace {
id UIViewController_nd_transitioningDelegateHandlers_creator(id owner) {
  return [[NDUIViewControllerTransitioningDelegateHandles alloc]
      initWithOwner:owner];
}
}

- (__kindof id<NDUIViewControllerTransitioningDelegateHandles>)
    nd_transitioningDelegateHandlers {
  return GetAssociatedObject<
      UIViewController_nd_transitioningDelegateHandlers_creator,
      OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
      self, @selector(nd_transitioningDelegateHandlers));
}

- (UIViewController* _Nullable)nd_topPresentedViewController {
  auto top = self.presentedViewController;
  auto presented = top.presentedViewController;
  while (presented) {
    top = presented;
    presented = top.presentedViewController;
  }

  return top;
}

- (UIViewController* _Nullable)nd_bottomPresentingViewController {
  auto bottom = self.presentingViewController;
  auto presenting = bottom.presentingViewController;
  while (presenting) {
    bottom = presenting;
    presenting = bottom.presentingViewController;
  }

  return bottom;
}

- (void)nd_dismissWithAnimated:(BOOL)animated
                    completion:(void (^)(void))completion {
  auto presenting = self.presentingViewController;

  if (presenting.presentedViewController == self) {
    [presenting dismissViewControllerAnimated:animated completion:completion];
  }
}

@end
