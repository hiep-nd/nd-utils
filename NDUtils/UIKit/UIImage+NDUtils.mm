//
//  UIImage+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/12/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIImage+NDUtils.h>

#import <NDUtils/NSObject+NDUtils.h>

using namespace nd::objc;

@implementation UIImage (NDUtils)

+ (UIImage*)nd_appIcon {
  auto icons =
      Cast<NSDictionary>(NSBundle.mainBundle.infoDictionary[@"CFBundleIcons"]);
  auto primaryIcons = Cast<NSDictionary>(icons[@"CFBundlePrimaryIcon"]);
  auto iconFiles = Cast<NSArray>(primaryIcons[@"CFBundleIconFiles"]);
  auto lastIcon = Cast<NSString>(iconFiles.lastObject);
  return lastIcon ? [UIImage imageNamed:lastIcon] : nil;
}

@end
