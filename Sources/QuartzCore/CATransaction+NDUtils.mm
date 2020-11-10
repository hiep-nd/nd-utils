//
//  CATransaction+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/CATransaction+NDUtils.h>

#import <NDUtils/NDMacros+NDUtils.h>

void NDAttachToAnimationCompletion(void(NS_NOESCAPE ^ animation)(void),
                                   void (^completion)(void)) {
  [CATransaction begin];
  CATransaction.completionBlock = completion;
  NDCallIfCan(animation);
  [CATransaction commit];
}
