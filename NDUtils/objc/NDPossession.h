//
//  NDPossession.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDPossession<__covariant Owner : id <NSObject>> : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithOwner:(Owner)owner NS_DESIGNATED_INITIALIZER;
@property(nonatomic, weak, readonly) Owner owner;

@end

NS_ASSUME_NONNULL_END
