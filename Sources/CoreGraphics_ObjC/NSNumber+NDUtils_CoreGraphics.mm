//
//  NSNumber+NDUtils_CoreGraphics.m
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 06/01/2021.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NSNumber+NDUtils_CoreGraphics.h>

@implementation NSNumber (NDUtils_CoreGraphics)
- (CGFloat)nd_CGFloatValue {
  return self.doubleValue;
}
@end
