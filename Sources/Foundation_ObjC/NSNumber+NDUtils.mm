//
//  NSNumber+NDUtils.m
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 06/01/2021.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NSNumber+NDUtils.h>

@implementation NSNumber (NDUtils)

- (NSTimeInterval)nd_NSTimeIntervalValue {
  return self.doubleValue;
}

@end
