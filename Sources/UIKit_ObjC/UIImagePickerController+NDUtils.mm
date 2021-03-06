//
//  UIImagePickerController+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIImagePickerController+NDUtils.h>

#import <NDLog/NDLog.h>
#import <NDUtils/objc+NDUtils.h>

#import <map>

using namespace nd::objc;
using namespace std;

@implementation NDUIImagePickerControllerDelegateHandlers

namespace {
template <typename T>
void Set(NDUIImagePickerControllerDelegateHandlers* self, T& lv, T rv) {
  nd::objc::Set<OBJC_ASSOCIATION_COPY_NONATOMIC>(self, lv, rv);
  self.owner.delegate = nil;
  self.owner.delegate = self;
}
}

@synthesize didFinishPickingMediaWithInfo = _didFinishPickingMediaWithInfo;
- (void)setDidFinishPickingMediaWithInfo:
    (void (^)(__kindof UIImagePickerController* _Nonnull,
              NSDictionary<UIImagePickerControllerInfoKey, id>* _Nonnull))
        didFinishPickingMediaWithInfo {
  Set(self, _didFinishPickingMediaWithInfo, didFinishPickingMediaWithInfo);
}

@synthesize didCancel = _didCancel;
- (void)setDidCancel:
    (void (^)(__kindof UIImagePickerController* _Nonnull))didCancel {
  Set(self, _didCancel, didCancel);
}

- (instancetype)initWithOwner:(id)owner {
  self = [super initWithOwner:owner];
  if (self) {
    self.didFinishPickingMediaWithInfo =
        ^(UIImagePickerController* ctrl,
          NSDictionary<UIImagePickerControllerInfoKey, id>*) {
          [ctrl dismissViewControllerAnimated:YES completion:nil];
        };
    self.didCancel = ^(__kindof UIImagePickerController* ctrl) {
      [ctrl dismissViewControllerAnimated:YES completion:nil];
    };
  }
  return self;
}

// MARK:- UIImagePickerControllerDelegate - optionals
- (void)imagePickerController:(UIImagePickerController*)picker
    didFinishPickingMediaWithInfo:
        (NSDictionary<UIImagePickerControllerInfoKey, id>*)info {
  if (self.owner != picker) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self, picker);
  } else {
    NDCallAndReturnIfCan(self.didFinishPickingMediaWithInfo, picker, info);
    NDAssertionFailure(
        @"Miscalled method '%s' before set handler '%@'.", __PRETTY_FUNCTION__,
        NSStringFromSelector(@selector(didFinishPickingMediaWithInfo)));
  }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker {
  if (self.owner != picker) {
    NDAssertionFailure(@"Misused of '%@' as '%@' delegate.", self, picker);
  } else {
    NDCallAndReturnIfCan(self.didCancel, picker);
    NDAssertionFailure(@"Miscalled method '%s' before set handler '%@'.",
                       __PRETTY_FUNCTION__,
                       NSStringFromSelector(@selector(didCancel)));
  }
}

// MARK:- NSObject
- (BOOL)respondsToSelector:(SEL)aSelector {
  // clang-format off
  static auto selectorsMap = ([]() {
    auto builder = map<SEL, BOOL (^)(NDUIImagePickerControllerDelegateHandlers*)>({
      {
        @selector(imagePickerController:didFinishPickingMediaWithInfo:),
        ^BOOL(NDUIImagePickerControllerDelegateHandlers* self) {
          return self.didFinishPickingMediaWithInfo!= nil;
        }
      },
      {
        @selector(imagePickerControllerDidCancel:),
        ^BOOL(NDUIImagePickerControllerDelegateHandlers* self) {
          return self.didCancel!= nil;
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

@implementation UIImagePickerController (NDUtils)

namespace {
id UIImagePickerController_nd_delegateHandlers_creator(id owner) {
  return
      [[NDUIImagePickerControllerDelegateHandlers alloc] initWithOwner:owner];
}
}

- (NDUIImagePickerControllerDelegateHandlers*)nd_delegateHandlers {
  return GetAssociatedObject<
      UIImagePickerController_nd_delegateHandlers_creator,
      OBJC_ASSOCIATION_RETAIN_NONATOMIC>(self, @selector(nd_delegateHandlers));
}

@end
