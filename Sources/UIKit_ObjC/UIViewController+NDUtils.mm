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

- (instancetype)initWithOwner:(UIViewController*)owner {
  self = [super initWithOwner:owner];
  if (self) {
    owner.transitioningDelegate = self;
  }
  return self;
}

// MARK: - NDUIViewControllerTransitioningDelegateHandles

@synthesize animationControllerForDismissedController;
@synthesize
    animationControllerForPresentedControllerPresentingControllerSourceController;
@synthesize interactionControllerForDismissal;
@synthesize interactionControllerForPresentation;
@synthesize
    presentationControllerForPresentedViewControllerPresentingViewControllerSourceViewController;

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

@end
