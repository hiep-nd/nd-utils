//
//  NDLocalizedString.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 10/19/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/NSBundle+NDUtils.h>

#define NDLocalizedStringFunc_Default_Impl(Func, ObjType, subBundle, tbl) \
  inline NSString* Func(NSString* key) {                                  \
    static NSBundle* bundle = NDSubBundle(ObjType.class, (subBundle));    \
    return NSLocalizedStringFromTableInBundle(key, tbl, bundle, nil);     \
  }

#define NDLocalizedString_Default_Impl(ObjType, subBundle, tbl) \
  NDLocalizedStringFunc_Default_Impl(NDLocalizedString, ObjType, subBundle, tbl)
