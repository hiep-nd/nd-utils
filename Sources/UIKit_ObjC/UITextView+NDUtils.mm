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

#import <map>

using namespace nd::objc;
using namespace std;

@interface NDUIUITextViewDelegateHandlers () <UITextViewDelegate>
@end

@implementation NDUIUITextViewDelegateHandlers

// MARK: - UITextViewDelegate - optionals
- (void)textViewDidBeginEditing:(UITextView*)textView {
  if (self.owner != textView) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self, textView);
  } else {
    NDCallAndReturnIfCan(self.didBeginEditing, textView);
    NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                       __PRETTY_FUNCTION__,
                       NSStringFromSelector(@selector(didBeginEditing)));
  }
}

// MARK:- NSObject
- (BOOL)respondsToSelector:(SEL)aSelector {
  // clang-format off
  static auto selectorsMap = ([]() {
    auto builder = map<SEL, BOOL (^)(NDUIUITextViewDelegateHandlers*)>({
      {
        @selector(textViewDidBeginEditing:),
        ^BOOL(NDUIUITextViewDelegateHandlers* self) {
          return self.didBeginEditing!= nil;
        }
      }
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

- (void)nd_enableBorderStyleRoundedRect {
  self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
  self.layer.borderWidth = 1;
  self.layer.cornerRadius = 5;
}

@end
