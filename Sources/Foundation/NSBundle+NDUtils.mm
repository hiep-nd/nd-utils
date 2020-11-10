//
//  NSBundle+NDUtils.m
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 10/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NSBundle+NDUtils.h>

NSBundle* NDSubBundle(Class containerCls, NSString* name) {
  return nd::objc::SubBundle(containerCls, name);
}
