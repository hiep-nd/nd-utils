//
//  NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 5/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for NDUtils.
FOUNDATION_EXPORT double NDUtilsVersionNumber;

//! Project version string for NDUtils.
FOUNDATION_EXPORT const unsigned char NDUtilsVersionString[];

#if !defined(__has_include)
#error \
    "NDUtils.h won't import anything if your compiler doesn't support \
          __has_include. Please import the headers individually."
#else

#if __has_include(<NDUtils/libextobjc+NDUtils.h>)
#import <NDUtils/libextobjc+NDUtils.h>
#endif

#if __has_include(<NDUtils/objc+NDUtils.h>)
#import <NDUtils/objc+NDUtils.h>
#endif

#if __has_include(<NDUtils/Foundation+NDUtils.h>)
#import <NDUtils/Foundation+NDUtils.h>
#endif

#if __has_include(<NDUtils/QuartzCore+NDUtils.h>)
#import <NDUtils/QuartzCore+NDUtils.h>
#endif

#if __has_include(<NDUtils/UIKit+NDUtils.h>)
#import <NDUtils/UIKit+NDUtils.h>
#endif

#endif
