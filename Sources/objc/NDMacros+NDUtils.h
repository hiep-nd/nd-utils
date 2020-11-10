//
//  NDMacros+NDUtils.h
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 6/24/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#define NDCallIfCan(block, ...) \
  do {                          \
    if (block) {                \
      block(__VA_ARGS__);       \
    }                           \
  } while (0)
#define NDCallAndReturnIfCan(block, ...) \
  do {                                   \
    if (block) {                         \
      return block(__VA_ARGS__);         \
    }                                    \
  } while (0)
