//
//  UIViewController+NDUtils_PanDownToDismiss.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NDUtils_PanDownToDismiss)

@property(nonatomic, assign, readonly) BOOL nd_panDownToDismiss;
- (void)nd_enablePanDownToDismissWithScrollView:
            (UIScrollView* _Nullable)scrollView
                 didFinishInteractiveTransition:
                     (void (^_Nullable)(void))didFinishInteractiveTransition;
- (void)nd_disablePanDownToDismiss;

@end

NS_ASSUME_NONNULL_END
