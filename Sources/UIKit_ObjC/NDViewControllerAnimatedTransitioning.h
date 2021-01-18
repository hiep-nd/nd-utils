//
//  NDViewControllerAnimatedTransitioning.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 05/01/2021.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDViewControllerAnimatedTransitioning
    : NSObject <UIViewControllerAnimatedTransitioning>

// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
@property(nonatomic, copy) NSTimeInterval (^_Nullable transitionDuration)
    (id<UIViewControllerContextTransitioning> _Nullable transitionContext);

// This method can only  be a nop if the transition is interactive and not a
// percentDriven interactive transition.
@property(nonatomic, copy) void (^_Nullable animateTransition)
    (id<UIViewControllerContextTransitioning> transitionContext);

/// A conforming object implements this method if the transition it creates can
/// be interrupted. For example, it could return an instance of a
/// UIViewPropertyAnimator. It is expected that this method will return the same
/// instance for the life of a transition.
@property(nonatomic, copy) id<UIViewImplicitlyAnimating> (
    ^_Nullable interruptibleAnimatorForTransition)
    (id<UIViewControllerContextTransitioning> transitionContext)
        API_AVAILABLE(ios(10.0));

// This is a convenience and if implemented will be invoked by the system when
// the transition context's completeTransition: method is invoked.
@property(nonatomic, copy) void (^_Nullable animationEnded)
    (BOOL transitionCompleted);

@end

API_AVAILABLE(ios(10.0))
@interface NDViewAnimating : NSObject <UIViewAnimating>

@property(nonatomic) UIViewAnimatingState state;

// Running indicates that the animation is running either in the forward or the
// reversed direction. The state of a running animation is always active.
@property(nonatomic, getter=isRunning) BOOL running;

// Reversed indicates that the animation is running in the reversed direction
// when running is YES. If running is NO, it indicates that it will run in the
// reversed direction when it is started.
@property(nonatomic, getter=isReversed) BOOL reversed;

// fractionComplete values are typically between 0 and 1. Some adopters may
// choose to give meaning to values less than zero and greater than 1 to
// facilitate over and undershooting.  The setter is usually a nop when the
// animation is running. Adopters are free to change this if it makes sense. An
// adopter may also choose to only return a meaningful result for this property
// if it is read while the animation is not running.
@property(nonatomic) CGFloat fractionComplete;

// Starts the animation either from an inactive state, or if the animation has
// been paused.
@property(nonatomic, copy) void (^_Nullable startAnimationHandler)(void);

// Starts the animation after the given delay.
@property(nonatomic, copy) void (^_Nullable startAnimationAfterDelay)
    (NSTimeInterval delay);

// Pauses an active, running animation, or start the animation as paused. This
// is different than stopping an animation.
@property(nonatomic, copy) void (^_Nullable pauseAnimationHandler)(void);

// Stops the animation.  The values of a view's animated property values are
// updated to correspond to the values that were last rendered. If
// withoutFinishing == YES, then the animator immediately becomes
// inactive. Otherwise it enters the stopped state and it is incumbent on the
// client to explicitly finish the animation by calling
// finishAnimationAtPosition:. Note when an animation finishes naturally this
// method is not called.
@property(nonatomic, copy) void (^_Nullable stopAnimation)
    (BOOL withoutFinishing);

// This method may only be called if the animator is in the stopped state.
// The finalPosition argument should indicate the final values of the animated
// properties.
- (void)finishAnimationAtPosition:(UIViewAnimatingPosition)finalPosition;
@property(nonatomic, copy) void (^_Nullable finishAnimationAtPosition)
    (UIViewAnimatingPosition finalPosition);

@end

API_AVAILABLE(ios(10.0))
@interface NDNotImplementedViewAnimating : NSObject <UIViewAnimating>
@end

API_AVAILABLE(ios(10.0))
@interface NDViewImplicitlyAnimating
    : NDViewAnimating <UIViewImplicitlyAnimating>

@property(nonatomic, copy) void (^_Nullable addAnimationsDelayFactor)
    (void (^animation)(void), CGFloat delayFactor);

@property(nonatomic, copy) void (^_Nullable addAnimations)
    (void (^animation)(void));

@property(nonatomic, copy) void (^_Nullable addCompletion)
    (void (^completion)(UIViewAnimatingPosition finalPosition));

@property(nonatomic, copy)
    void (^_Nullable continueAnimationWithTimingParametersDurationFactor)
        (id<UITimingCurveProvider> _Nullable parameters, CGFloat durationFactor)
            ;

@end

API_AVAILABLE(ios(10.0))
@interface NDNotImplementedViewImplicitlyAnimating
    : NDNotImplementedViewAnimating <UIViewImplicitlyAnimating>
@end

NS_ASSUME_NONNULL_END
