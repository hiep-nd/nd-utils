//
//  NSBundle+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 10/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <NDUtils/NSObject+NDUtils.h>

#import <NDLog/NDLog.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef __cplusplus
namespace nd {
namespace objc {
inline NSBundle* SubBundle(Class containerCls, NSString* name) {
  auto bundle = [NSBundle bundleForClass:containerCls];
  auto path = [bundle pathForResource:name ofType:@"bundle"];
  return [NSBundle bundleWithPath:path] ?: NSBundle.mainBundle;
}

template <typename RType>
inline RType* _Nullable BundleInfo(NSBundle* bundle, NSString* key) {
  if (!key) {
    NDCAssertionFailure(@"Can not get info with key: '%@'.", key);
    return nil;
  }
  return Cast<RType>([bundle objectForInfoDictionaryKey:key]);
}
}
}
#endif

FOUNDATION_EXPORT
NSBundle* NDSubBundle(Class containerCls, NSString* name);

@interface NSBundle (NSUtils)

@property(nonatomic, readonly) NSString* _Nullable nd_CFBundleVersion;
@property(nonatomic, readonly)
    NSString* _Nullable nd_CFBundleShortVersionString;
@property(nonatomic, readonly)
    NSString* _Nullable nd_CFBundleInfoDictionaryVersion;
@property(nonatomic, readonly) NSString* _Nullable nd_NSHumanReadableCopyright;

@end

NS_ASSUME_NONNULL_END
