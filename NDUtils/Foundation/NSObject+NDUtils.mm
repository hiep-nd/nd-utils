//
//  NSObject+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 6/24/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/Foundation/NSObject+NDUtils.h>

#import <NDLog/NDLog.h>

namespace {
void* kNDKeyValueObservationContext = &kNDKeyValueObservationContext;
}

@interface NDKeyValueObservation : NSObject

- (instancetype)initWithObject:(id)object
                       keyPath:(NSString*)keyPath
                       options:(NSKeyValueObservingOptions)options
                 changeHandler:(void (^)(id, NSDictionary*))changeHandler;

@end

@implementation NDKeyValueObservation {
  __weak id _object;
  NSString* _keyPath;
  void (^_changeHandler)(id, NSDictionary*);
}

- (instancetype)initWithObject:(id)object
                       keyPath:(NSString*)keyPath
                       options:(NSKeyValueObservingOptions)options
                 changeHandler:(void (^)(id, NSDictionary*))changeHandler {
  NDAssert(object && keyPath && changeHandler,
           @"Can not create observation with object: '%@' key path: '%@' "
           @"change handler: '%@'.",
           object, keyPath, changeHandler);
  if (!(object && keyPath && changeHandler)) {
    return nil;
  }

  self = [super init];
  if (self) {
    _object = object;
    _keyPath = [keyPath copy];
    _changeHandler = [changeHandler copy];
    [object addObserver:self
             forKeyPath:keyPath
                options:options
                context:kNDKeyValueObservationContext];
  }

  return self;
}

- (void)dealloc {
  @try {
    [_object removeObserver:self forKeyPath:_keyPath];
  } @catch (NSException* exception) {
    NDAssert(!exception,
             @"Can not remove observation with object: '%@' key path: '%@' "
             @"error: '%@'.",
             _object, _keyPath, exception);
  }
}

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context {
  if (context == kNDKeyValueObservationContext) {
    _changeHandler(object, change);
  } else {
    [super observeValueForKeyPath:keyPath
                         ofObject:object
                           change:change
                          context:context];
  }
}

@end

@implementation NSObject (NDUtils)

- (id<NSObject>)nd_observeKeyPath:(NSString*)keyPath
                          options:(NSKeyValueObservingOptions)options
                    changeHandler:(void (^)(id, NSDictionary*))changeHandler {
  return [[NDKeyValueObservation alloc] initWithObject:self
                                               keyPath:keyPath
                                               options:options
                                         changeHandler:changeHandler];
}

@end
