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

using namespace nd::objc;

@interface NDUITextFieldDelegateHandlers () <UITextFieldDelegate>
@end

@implementation NDUITextFieldDelegateHandlers

- (instancetype)initWithOwner:(UITextField*)owner {
  self = [super initWithOwner:owner];
  if (self) {
    owner.delegate = self;
  }
  return self;
  ;
}

// MARK: - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField*)textField {
  if (self.owner != textField) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self, textField);
  } else {
    NDCallAndReturnIfCan(self.didBeginEditing, textField);
  }
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
  if (self.owner != textField) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self, textField);
  } else {
    NDCallAndReturnIfCan(self.shouldReturn, textField);
  }
  return YES;
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
