//
//  UINavigationController+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UINavigationController+NDUtils.h>

#import <NDUtils/UIGestureRecognizer+NDUtils.h>

#import <NDLog/NDLog.h>
#import <NDUtils/QuartzCore+NDUtils.h>
#import <NDUtils/libextobjc+NDUtils.h>
#import <NDUtils/objc+NDUtils.h>

using namespace nd::objc;

@implementation NDUINavigationControllerDelegateHandlers

- (instancetype)initWithOwner:(UINavigationController*)owner {
  self = [super initWithOwner:owner];
  if (self) {
    owner.delegate = self;
  }
  return self;
}

@end

@implementation UINavigationController (NDUtils)

namespace {
id UINavigationController_nd_delegateHandlers_creator(id owner) {
  return [[NDUINavigationControllerDelegateHandlers alloc] initWithOwner:owner];
}
}

- (NDUINavigationControllerDelegateHandlers*)nd_delegateHandlers {
  return GetAssociatedObject<UINavigationController_nd_delegateHandlers_creator,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
      self, @selector(nd_delegateHandlers));
}

- (NSArray<__kindof UIViewController*>*)
    nd_popToViewController:(UIViewController*)viewController
                  animated:(BOOL)animated
                completion:(void (^)(void))completion {
  return nd::attachToAnimation(
      ^{
        return [self popToViewController:viewController animated:animated];
      },
      completion);
}

- (NSArray<__kindof UIViewController*>*)
    nd_popToPreviousViewController:(UIViewController*)viewController
                          animated:(BOOL)animated
                        completion:(void (^)(void))completion {
  auto index = [self.viewControllers indexOfObject:viewController];
  if (index == NSNotFound || index == 0) {
    NDAssertionFailure(
        @"Can not pop to previous UIViewController: '%@' of "
        @"UINavigationController: '%@' because the index is: '%lu'.",
        viewController, self, (unsigned long)index);
    return @[];
  }

  return [self nd_popToViewController:self.viewControllers[index - 1]
                             animated:YES
                           completion:completion];
}

- (void)nd_enableInteractivePopGestureRecognizerWithViewControllersCount {
  @weakify(self);
  self.interactivePopGestureRecognizer.nd_delegateHandlers.shouldBegin =
      ^BOOL(__kindof UIGestureRecognizer* _Nonnull) {
        @strongify(self);
        return self.viewControllers.count > 1;
      };
}
@end
