//
//  UIScrollView+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIScrollView+NDUtils.h>

#import <NDUtils/runtime+NDUtils.h>

using namespace nd::objc;

@interface NDUIScrollViewDelegateHandlers () <UIScrollViewDelegate>
@end

@implementation NDUIScrollViewDelegateHandlers

- (instancetype)initWithOwner:(UIScrollView*)owner {
  self = [super initWithOwner:owner];
  if (self) {
    owner.delegate = self;
  }
  return self;
}

@end

@implementation UIScrollView (NDUtils)

namespace {
id UIScrollView_nd_delegateHandlers_creator(id owner) {
  return [[NDUIScrollViewDelegateHandlers alloc] initWithOwner:owner];
}
}

- (NDUIScrollViewDelegateHandlers*)nd_delegateHandlers {
  return GetAssociatedObject<UIScrollView_nd_delegateHandlers_creator,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
      self, @selector(nd_delegateHandlers));
}

@end
