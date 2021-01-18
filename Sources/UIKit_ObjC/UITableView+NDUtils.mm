//
//  UITableView+NDUtils.mm
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 12/01/2020.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

#import <NDUtils/UITableView+NDUtils.h>

@implementation UITableView (NDUtils)

- (void)nd_relayoutCells {
  [self beginUpdates];
  [self endUpdates];
}

@end
