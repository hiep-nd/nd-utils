//
//  UINavigationController+NDUtils.swift
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

import UIKit

extension UINavigationController {
  /// Pops view controllers until the one specified is on top. Returns the popped controllers.
  @inlinable
  @discardableResult
  public func nd_popToViewController(
    _ viewController: UIViewController,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) -> [UIViewController]? {
    self.__nd_pop(
      to: viewController, animated: animated, completion: completion
    )
  }

  /// Pops view controllers until the one specified's previous is on top. Returns the popped controllers.
  @inlinable
  @discardableResult
  public func nd_popToPreviousViewController(
    _ viewController: UIViewController,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) -> [UIViewController]? {
    self.__nd_pop(
      toPreviousViewController: viewController,
      animated: animated,
      completion: completion
    )
  }
}
