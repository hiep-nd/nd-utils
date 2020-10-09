//
//  NSString+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 6/23/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NSString+NDUtils.h>

#import <NDLog/NDLog.h>
#import <UIKit/UIKit.h>

@interface NDMemoryCache<__covariant KeyType, __covariant ObjectType> : NSObject

- (nullable ObjectType)objectForKeyedSubscript:(KeyType)key;
- (void)setObject:(nullable ObjectType)obj
    forKeyedSubscript:(KeyType<NSCopying>)key;

@end

@implementation NDMemoryCache {
  NSMutableDictionary* _cache;
  id<NSObject> _observation;
}

- (id)objectForKeyedSubscript:(id)key {
  return _cache[key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
  _cache[key] = obj;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _cache = [[NSMutableDictionary alloc] init];
    auto cache = _cache;
    _observation = [NSNotificationCenter.defaultCenter
        addObserverForName:UIApplicationDidReceiveMemoryWarningNotification
                    object:nil
                     queue:nil
                usingBlock:^(NSNotification*) {
                  [cache removeAllObjects];
                }];
  }
  return self;
}

@end

namespace {
auto cache = [[NDMemoryCache<NSString*, NSString*> alloc] init];
}

@implementation NSString (NDUtils)

+ (instancetype)nd_stringNamed:(NSString*)name {
  if (!name) {
    NDAssertionFailure(@"Invalid string name: '%@'.", name);
    return nil;
  }

  auto obj = cache[name];
  if (obj) {
    return obj;
  }

  auto url = [NSBundle.mainBundle URLForResource:name withExtension:nil];
  if (!url) {
    NDAssertionFailure(@"Invalid string name: '%@'.", name);
    return nil;
  }

  obj = [NSString stringWithContentsOfURL:url
                             usedEncoding:nullptr
                                    error:nullptr];
  if (!obj) {
    NDAssertionFailure(@"Can not read string from resource name: '%@'.", name);
    return nil;
  }

  cache[name] = obj;
  return obj;
}

- (BOOL)nd_containsRegexPattern:(NSString*)pattern {
  NSError* err = nil;
  auto regex = [[NSRegularExpression alloc] initWithPattern:pattern
                                                    options:kNilOptions
                                                      error:&err];
  if (err) {
    NDAssertionFailure(@"Invalid regex pattern: '%@'.", pattern);
    return NO;
  }

  return [regex firstMatchInString:self
                           options:kNilOptions
                             range:NSMakeRange(0, self.length)];
}

- (BOOL)nd_matchsRegexPattern:(NSString*)pattern {
  if (!pattern) {
    NDAssertionFailure(@"Invalid regex pattern: '%@'.", pattern);
    return NO;
  }

  return [self
      nd_containsRegexPattern:[NSString stringWithFormat:@"^%@$", pattern]];
}

@end
