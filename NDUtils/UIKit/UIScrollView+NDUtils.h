//
//  UIScrollView+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NDUtils/objc/NDPossession.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDUIScrollViewDelegateHandlers : NDPossession <UIScrollView*>
@end

@interface UIScrollView (NDUtils)

@property(nonatomic, strong, readonly)
    NDUIScrollViewDelegateHandlers* nd_delegateHandlers;

@end

NS_ASSUME_NONNULL_END