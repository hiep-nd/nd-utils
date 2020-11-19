//
//  NSBundle+NDUtils.m
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 10/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NSBundle+NDUtils.h>

using namespace nd::objc;

NSBundle* NDSubBundle(Class containerCls, NSString* name) {
  return SubBundle(containerCls, name);
}

@implementation NSBundle (NDUtils)

- (NSString*)nd_CFBundleVersion {
  return BundleInfo<NSString>(self, @"CFBundleVersion");
}

- (NSString*)nd_CFBundleShortVersionString {
  return BundleInfo<NSString>(self, @"CFBundleShortVersionString");
}

- (NSString*)nd_CFBundleInfoDictionaryVersion {
  return BundleInfo<NSString>(self, @"CFBundleInfoDictionaryVersion");
}

- (NSString*)nd_NSHumanReadableCopyright {
  return BundleInfo<NSString>(self, @"NSHumanReadableCopyright");
}

@end
