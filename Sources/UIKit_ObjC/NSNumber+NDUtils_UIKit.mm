//
//  NSNumber+NDUtils_UIKit.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 06/01/2021.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NSNumber+NDUtils_UIKit.h>

@implementation NSNumber (NDUtils_UIKit)

- (UIRectEdge)nd_UIRectEdgeValue {
  return (UIRectEdge)self.unsignedIntegerValue;
}

@end
