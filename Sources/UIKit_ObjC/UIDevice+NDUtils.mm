//
//  UIDevice+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/14/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIDevice+NDUtils.h>

#import <sys/utsname.h>

using namespace std;

namespace {
inline const utsname& SystemInfo() {
  static utsname systemInfo;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    uname(&systemInfo);
  });
  return systemInfo;
}
}

@implementation UIDevice (NDUtils)

- (NSString*)nd_name {
  return [NSString stringWithCString:SystemInfo().machine
                            encoding:NSUTF8StringEncoding];
}

- (NSString*)nd_os {
  return [NSString stringWithCString:SystemInfo().sysname
                            encoding:NSUTF8StringEncoding];
}

- (NSString*)nd_networkNode {
  return [NSString stringWithCString:SystemInfo().nodename
                            encoding:NSUTF8StringEncoding];
}

- (NSString*)nd_release {
  return [NSString stringWithCString:SystemInfo().release
                            encoding:NSUTF8StringEncoding];
}

- (NSString*)nd_version {
  return [NSString stringWithCString:SystemInfo().version
                            encoding:NSUTF8StringEncoding];
}

@end
