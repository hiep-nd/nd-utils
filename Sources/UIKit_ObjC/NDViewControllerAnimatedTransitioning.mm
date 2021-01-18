//
//  NDViewControllerAnimatedTransitioning.m
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 05/01/2021.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NDViewControllerAnimatedTransitioning.h>

#import <NDUtils/NDMacros+NDUtils.h>

#import <NDLog/NDLog.h>

#import <map>

using namespace std;

@implementation NDViewControllerAnimatedTransitioning

// MARK:- UIViewControllerAnimatedTransitioning - requireds
- (NSTimeInterval)transitionDuration:
    (nullable id<UIViewControllerContextTransitioning>)transitionContext {
  NDCallAndReturnIfCan(self.transitionDuration, transitionContext);
  return 0;
}

- (void)animateTransition:
    (id<UIViewControllerContextTransitioning>)transitionContext {
  NDCallAndReturnIfCan(self.animateTransition, transitionContext);
}

// MARK:- UIViewControllerAnimatedTransitioning - optionals
- (id<UIViewImplicitlyAnimating>)interruptibleAnimatorForTransition:
    (id<UIViewControllerContextTransitioning>)transitionContext
    API_AVAILABLE(ios(10.0)) {
  NDCallAndReturnIfCan(self.interruptibleAnimatorForTransition,
                       transitionContext);
  NDAssertionFailure(
      @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
      NSStringFromSelector(@selector(interruptibleAnimatorForTransition)));
  return [[NDNotImplementedViewImplicitlyAnimating alloc] init];
}

- (void)animationEnded:(BOOL)transitionCompleted {
  NDCallAndReturnIfCan(self.animationEnded, transitionCompleted);
  NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                     __PRETTY_FUNCTION__,
                     NSStringFromSelector(@selector(animationEnded)));
}

// MARK:- NSObject
- (BOOL)respondsToSelector:(SEL)aSelector {
  // clang-format off
  static auto selectorsMap = ([]() {
    auto builder = map<SEL, BOOL (^)(NDViewControllerAnimatedTransitioning*)>({
      {
        @selector(animationEnded:),
        ^BOOL(NDViewControllerAnimatedTransitioning* self) {
          return self.animationEnded!= nil;
        }
      }
    });

    if (@available(iOS 10.0, *)) {
      builder.insert({
        {
          @selector(interruptibleAnimatorForTransition:),
          ^BOOL(NDViewControllerAnimatedTransitioning* self) {
            return self.interruptibleAnimatorForTransition!= nil;
          }
        }
      });
    }
    
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

@implementation NDViewAnimating

- (void)finishAnimationAtPosition:(UIViewAnimatingPosition)finalPosition {
  NDCallIfCan(self.finishAnimationAtPosition, finalPosition);
}

- (void)pauseAnimation {
  NDCallIfCan(self.pauseAnimationHandler);
}

- (void)startAnimation {
  NDCallIfCan(self.startAnimationHandler);
}

- (void)startAnimationAfterDelay:(NSTimeInterval)delay {
  NDCallIfCan(self.startAnimationAfterDelay, delay);
}

- (void)stopAnimation:(BOOL)withoutFinishing {
  NDCallIfCan(self.stopAnimation, withoutFinishing);
}

@end

@implementation NDViewImplicitlyAnimating

// MARK:- UIViewImplicitlyAnimating - optionals
- (void)addAnimations:(void (^)(void))animation
          delayFactor:(CGFloat)delayFactor {
  NDCallAndReturnIfCan(self.addAnimationsDelayFactor, animation, delayFactor);
  NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                     __PRETTY_FUNCTION__,
                     NSStringFromSelector(@selector(addAnimationsDelayFactor)));
}

- (void)addAnimations:(void (^)(void))animation {
  NDCallAndReturnIfCan(self.addAnimations, animation);
  NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                     __PRETTY_FUNCTION__,
                     NSStringFromSelector(@selector(addAnimations)));
}

- (void)addCompletion:
    (void (^)(UIViewAnimatingPosition finalPosition))completion {
  NDCallAndReturnIfCan(self.addCompletion, completion);
  NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                     __PRETTY_FUNCTION__,
                     NSStringFromSelector(@selector(addCompletion)));
}

- (void)continueAnimationWithTimingParameters:
            (nullable id<UITimingCurveProvider>)parameters
                               durationFactor:(CGFloat)durationFactor {
  NDCallAndReturnIfCan(self.continueAnimationWithTimingParametersDurationFactor,
                       parameters, durationFactor);
  NDAssertionFailure(
      @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
      NSStringFromSelector(
          @selector(continueAnimationWithTimingParametersDurationFactor)));
}

@end

@implementation NDNotImplementedViewAnimating

- (UIViewAnimatingState)state {
  return UIViewAnimatingStateInactive;
}

- (BOOL)isRunning {
  return NO;
}

- (BOOL)isReversed {
  return NO;
}

- (void)setReversed:(BOOL)reversed {
}

- (CGFloat)fractionComplete {
  return 0;
}

- (void)setFractionComplete:(CGFloat)fractionComplete {
}

- (void)finishAnimationAtPosition:(UIViewAnimatingPosition)finalPosition {
}

- (void)pauseAnimation {
}

- (void)startAnimation {
}

- (void)startAnimationAfterDelay:(NSTimeInterval)delay {
}

- (void)stopAnimation:(BOOL)withoutFinishing {
}

@end

@implementation NDNotImplementedViewImplicitlyAnimating
@end
