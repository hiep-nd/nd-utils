//
//  UINavigationController+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NDUtils/NDPossession.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDUINavigationControllerDelegateHandlers
    : NDPossession <UINavigationController*>
@end

@interface UINavigationController (NDUtils)

@property(nonatomic, strong, readonly)
    NDUINavigationControllerDelegateHandlers* nd_delegateHandlers;

/// Pops view controllers until the one specified is on top. Returns the popped
/// controllers.
- (nullable NSArray<__kindof UIViewController*>*)
    nd_popToViewController:(UIViewController*)viewController
                  animated:(BOOL)animated
                completion:(void (^_Nullable)(void))completion
    NS_REFINED_FOR_SWIFT;

/// Pops view controllers until the one specified's previous is on top. Returns
/// the popped controllers.
- (nullable NSArray<__kindof UIViewController*>*)
    nd_popToPreviousViewController:(UIViewController*)viewController
                          animated:(BOOL)animated
                        completion:(void (^_Nullable)(void))completion
    NS_REFINED_FOR_SWIFT;

@end

NS_ASSUME_NONNULL_END
