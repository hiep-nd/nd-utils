//
//  NSAttributedString+NDUtils_UIKit.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NSAttributedString+NDUtils_UIKit.h>

@implementation NSAttributedString (NDUtils_UIKit)

- (UIImage*)nd_image {
  auto size = self.size;
  UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
  [self drawInRect:{CGPointZero, size}];
  auto image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

@end
