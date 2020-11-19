//
//  NSError+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 17/11/2020.
//

#import <NDUtils/NSError+NDUtils.h>

#import <NDUtils/NSFastEnumeration+NDUtils.h>

#import <NDLog/NDLog.h>

using namespace nd::objc;

NSErrorDomain const kNDErrorDomain = @"nd.objc";
NSInteger const kNDErrorCodeRuntime = 1;
NSErrorUserInfoKey const kNDFileKey = @"file";
NSErrorUserInfoKey const kNDFunctionKey = @"function";
NSErrorUserInfoKey const kNDLineKey = @"line";
NSErrorUserInfoKey const kNDMessageKey = @"message";
NSErrorUserInfoKey const kNDTagKey = @"tag";

@implementation NSError (NDUtils)

+ (instancetype)nd_runtimeErrorWithMessage:(NSString*)message
                                       tag:(NSString*)tag
                                  function:(NSString*)function
                                      file:(NSString*)file
                                      line:(NSUInteger)line {
  return [[self alloc] initWithDomain:kNDErrorDomain
                                 code:kNDErrorCodeRuntime
                             userInfo:SafeNSMutableDictionary({
                                          {kNDFileKey, file},
                                          {kNDFunctionKey, function},
                                          {kNDLineKey, @(line)},
                                          {kNDMessageKey, message},
                                          {kNDTagKey, tag},
                                      })];
}

@end
