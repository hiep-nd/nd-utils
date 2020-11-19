//
//  NSError+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 17/11/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const kNDErrorDomain;
FOUNDATION_EXPORT NSInteger const kNDErrorCodeRuntime;
FOUNDATION_EXPORT NSErrorUserInfoKey const kNDFileKey;
FOUNDATION_EXPORT NSErrorUserInfoKey const kNDFunctionKey;
FOUNDATION_EXPORT NSErrorUserInfoKey const kNDLineKey;
FOUNDATION_EXPORT NSErrorUserInfoKey const kNDMessageKey;
FOUNDATION_EXPORT NSErrorUserInfoKey const kNDTagKey;

@interface NSError (NDUtils)

+ (instancetype)nd_runtimeErrorWithMessage:(NSString*)message
                                       tag:(NSString* _Nullable)tag
                                  function:(NSString*)function
                                      file:(NSString*)file
                                      line:(NSUInteger)line
    NS_REFINED_FOR_SWIFT;

@end

#define NDRuntimeErrorTag(_message, _tag)                    \
  [NSError nd_runtimeErrorWithMessage:_message               \
                                  tag:_tag                   \
                             function:@(__PRETTY_FUNCTION__) \
                                 file:@(__FILE__)            \
                                 line:__LINE__];
#define NDRuntimeError(_message) NDRuntimeErrorTag(_message, nil)

NS_ASSUME_NONNULL_END
