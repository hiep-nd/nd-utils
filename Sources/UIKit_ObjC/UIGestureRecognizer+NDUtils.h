//
//  UIGestureRecognizer+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 16/12/2020.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NDUtils/NDPossession.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NDUIGestureRecognizerDelegateHandlersProtocol)
@protocol NDUIGestureRecognizerDelegateHandlers <NSObject>

// called when a gesture recognizer attempts to transition out of
// UIGestureRecognizerStatePossible. returning NO causes it to transition to
// UIGestureRecognizerStateFailed
@property(nonatomic, copy) BOOL (^_Nullable shouldBegin)
    (__kindof UIGestureRecognizer*);

// called when the recognition of one of gestureRecognizer or
// otherGestureRecognizer would be blocked by the other return YES to allow both
// to recognize simultaneously. the default implementation returns NO (by
// default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition.
// returning NO is not guaranteed to prevent simultaneous recognition, as the
// other gesture's delegate may return YES
@property(nonatomic, copy)
    BOOL (^_Nullable shouldRecognizeSimultaneouslyWithGestureRecognizer)
        (__kindof UIGestureRecognizer*,
         UIGestureRecognizer* otherGestureRecognizer);

// called once per attempt to recognize, so failure requirements can be
// determined lazily and may be set up between recognizers across view
// hierarchies return YES to set up a dynamic failure requirement between
// gestureRecognizer and otherGestureRecognizer
//
// note: returning YES is guaranteed to set up the failure requirement.
// returning NO does not guarantee that there will not be a failure requirement
// as the other gesture's counterpart delegate or subclass methods may return
// YES
@property(nonatomic,
          copy) BOOL (^_Nullable shouldRequireFailureOfGestureRecognizer)
    (__kindof UIGestureRecognizer*, UIGestureRecognizer* otherGestureRecognizer)
        API_AVAILABLE(ios(7.0));
@property(nonatomic,
          copy) BOOL (^_Nullable shouldBeRequiredToFailByGestureRecognizer)
    (__kindof UIGestureRecognizer*, UIGestureRecognizer* otherGestureRecognizer)
        API_AVAILABLE(ios(7.0));

// called before touchesBegan:withEvent: is called on the gesture recognizer for
// a new touch. return NO to prevent the gesture recognizer from seeing this
// touch
@property(nonatomic, copy) BOOL (^_Nullable shouldReceiveTouch)
    (__kindof UIGestureRecognizer*, UITouch* touch);

// called before pressesBegan:withEvent: is called on the gesture recognizer for
// a new press. return NO to prevent the gesture recognizer from seeing this
// press
@property(nonatomic, copy) BOOL (^_Nullable shouldReceivePress)
    (__kindof UIGestureRecognizer*, UIPress* press);

// called once before either -gestureRecognizer:shouldReceiveTouch: or
// -gestureRecognizer:shouldReceivePress: return NO to prevent the gesture
// recognizer from seeing this event
@property(nonatomic, copy) BOOL (^_Nullable shouldReceiveEvent)
    (__kindof UIGestureRecognizer*, UIEvent* event)
        API_AVAILABLE(ios(13.4), tvos(13.4)) API_UNAVAILABLE(watchos);

@end

// clang-format off
@interface NDUIGestureRecognizerDelegateHandlers
    : NDPossession <UIGestureRecognizer*><NDUIGestureRecognizerDelegateHandlers>
@end
// clang-format on

@interface UIGestureRecognizer (NDUtils)

@property(nonatomic, strong, readonly) id<NDUIGestureRecognizerDelegateHandlers>
    nd_delegateHandlers;

@end

NS_ASSUME_NONNULL_END
