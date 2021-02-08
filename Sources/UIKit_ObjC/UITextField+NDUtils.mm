//
//  UITextField+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UITextField+NDUtils.h>

#import <NDLog/NDLog.h>
#import <NDUtils/NDMacros+NDUtils.h>
#import <NDUtils/runtime+NDUtils.h>

#import <map>

using namespace nd::objc;
using namespace std;

@interface NDUITextFieldDelegateHandlers () <UITextFieldDelegate>
@end

@implementation NDUITextFieldDelegateHandlers

namespace {
template <typename T>
void Set(NDUITextFieldDelegateHandlers* self, T& lv, T rv) {
  nd::objc::Set<OBJC_ASSOCIATION_COPY_NONATOMIC>(self, lv, rv);
  self.owner.delegate = nil;
  self.owner.delegate = self;
}
}

@synthesize didBeginEditing = _didBeginEditing;
- (void)setDidBeginEditing:
    (void (^)(__kindof UITextField* _Nonnull))didBeginEditing {
  Set(self, _didBeginEditing, didBeginEditing);
}

@synthesize shouldReturn = _shouldReturn;
- (void)setShouldReturn:(BOOL (^)(__kindof UITextField* _Nonnull))shouldReturn {
  Set(self, _shouldReturn, shouldReturn);
}

- (instancetype)initWithOwner:(UITextField*)owner {
  self = [super initWithOwner:owner];
  if (self) {
    owner.delegate = self;
  }
  return self;
}

// MARK: - UITextFieldDelegate - optionals
- (void)textFieldDidBeginEditing:(UITextField*)textField {
  if (self.owner != textField) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self, textField);
  } else {
    NDCallAndReturnIfCan(self.didBeginEditing, textField);
    NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                       __PRETTY_FUNCTION__,
                       NSStringFromSelector(@selector(didBeginEditing)));
  }
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
  if (self.owner != textField) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self, textField);
  } else {
    NDCallAndReturnIfCan(self.shouldReturn, textField);
    NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                       __PRETTY_FUNCTION__,
                       NSStringFromSelector(@selector(shouldReturn)));
  }
  return YES;
}

// MARK:- NSObject
- (BOOL)respondsToSelector:(SEL)aSelector {
  // clang-format off
  static auto selectorsMap = ([]() {
    auto builder = map<SEL, BOOL (^)(NDUITextFieldDelegateHandlers*)>({
      {
        @selector(textFieldDidBeginEditing:),
        ^BOOL(NDUITextFieldDelegateHandlers* self) {
          return self.didBeginEditing!= nil;
        }
      },
      {
        @selector(textFieldShouldReturn:),
        ^BOOL(NDUITextFieldDelegateHandlers* self) {
          return self.shouldReturn!= nil;
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

@implementation UITextField (NDUtils)

namespace {
id UITextField_nd_delegateHandlers_creator(id owner) {
  return [[NDUITextFieldDelegateHandlers alloc] initWithOwner:owner];
}
}

- (NDUITextFieldDelegateHandlers*)nd_delegateHandlers {
  return GetAssociatedObject<UITextField_nd_delegateHandlers_creator,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC>(
      self, @selector(nd_delegateHandlers));
}

@end
