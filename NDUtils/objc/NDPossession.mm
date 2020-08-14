//
//  NDPossession.m
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/objc/NDPossession.h>

#import <NDLog/NDLog.h>

@implementation NDPossession

- (instancetype)initWithOwner:(id)owner {
  self = [super init];
  if (self) {
    if (owner) {
      _owner = owner;
    } else {
      NDAssertionFailure(@"Can not init with owner: '%@'.", owner);
    }
  }
  return self;
}

@end
