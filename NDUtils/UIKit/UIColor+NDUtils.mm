//
//  UIColor+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 5/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UIKit/UIColor+NDUtils.h>

#import <NDLog/NDLog.h>

@implementation UIColor (NDUtils)

+ (instancetype)nd_withRgb:(UInt32)rgb {
  return [self colorWithRed:CGFloat((rgb & 0xFF0000) >> 16) / 255
                      green:CGFloat((rgb & 0xFF00) >> 8) / 255
                       blue:CGFloat(rgb & 0xFF) / 255
                      alpha:1.0];
}

+ (instancetype)nd_withRgba:(UInt32)rgba {
  return [self colorWithRed:CGFloat((rgba & 0xFF000000) >> 24) / 255
                      green:CGFloat((rgba & 0xFF0000) >> 16) / 255
                       blue:CGFloat((rgba & 0xFF00) >> 8) / 255
                      alpha:CGFloat(rgba & 0xFF) / 255];
}

- (UInt32)nd_rgb {
  CGFloat r, g, b;
  auto isCompatibleWithRgb = [self getRed:&r green:&g blue:&b alpha:NULL];
  NDAssert(isCompatibleWithRgb,
           @"Color is not compatible with Rgb format: '%@'.", self);

  return isCompatibleWithRgb ? (UInt32(r * 255) << 16) |
                                   (UInt32(g * 255) << 8) | UInt32(b * 255)
                             : 0;
}

- (UInt32)nd_rgba {
  CGFloat r, g, b, a;
  auto isCompatibleWithRgb = [self getRed:&r green:&g blue:&b alpha:&a];
  NDAssert(isCompatibleWithRgb,
           @"Color is not compatible with Rgb format: '%@'.", self);

  return isCompatibleWithRgb
             ? (UInt32(r * 255) << 24) | (UInt32(g * 255) << 16) |
                   (UInt32(b * 255) << 8) | UInt32(a * 255)
             : 0;
}

@end
