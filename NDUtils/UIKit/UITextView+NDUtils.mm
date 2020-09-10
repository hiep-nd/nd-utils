//
//  UITextView+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UITextView+NDUtils.h>

#import <NDLog/NDLog.h>
#import <NDUtils/NDMacros+NDUtils.h>
#import <NDUtils/runtime+NDUtils.h>

using namespace nd::objc;

@interface NDUIUITextViewDelegateHandlers () <UITextViewDelegate>
@end

@implementation NDUIUITextViewDelegateHandlers

- (void)textViewDidBeginEditing:(UITextView*)textView {
  if (self.owner != textView) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self, textView);
  } else {
    NDCallAndReturnIfCan(self.didBeginEditing, textView);
  }
}

@end

@implementation UITextView (NDUtils)

namespace {
id UITextView_nd_delegateHandlers_creator(id owner) {
  return [[NDUIUITextViewDelegateHandlers alloc] initWithOwner:owner];
}
}

- (NDUIUITextViewDelegateHandlers*)nd_delegateHandlers {
  return GetAssociatedObject<UITextView_nd_delegateHandlers_creator,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
      self, @selector(nd_delegateHandlers));
}

@end
