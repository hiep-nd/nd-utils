//
//  UIFont+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 5/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIKit/UIFont+NDUtils.h>

#import <NDLog/NDLog.h>

@implementation UIFont (NDUtils)

+ (instancetype)nd_safeWithName:(NSString*)fontName size:(CGFloat)size {
  auto font = [self fontWithName:fontName size:size];
  NDAssert(font, @"Invalid font name: '%@' and size: '%@'.", fontName, @(size));

  return font ?: [self systemFontOfSize:size];
}

@end
