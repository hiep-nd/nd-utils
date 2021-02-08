//
//  UIViewController+NDUtils.swift
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 08/02/2020.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

extension UIViewController {
  /// Dismiss this view controller.
  /// - Parameters:
  ///   - animated: The animated.
  ///   - completion: The completion.
  @inlinable
  public func nd_dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
    __nd_dismissWith(animated: animated, completion: completion)
  }

  /// Present view controller.
  /// - Parameters:
  ///   - viewControllerToPresent: The presented view controller.
  ///   - flag: The animated.
  ///   - completion: The completion.
  @inlinable
  public func nd_present(_ viewControllerToPresent: UIViewController, animated flag: Bool = true, completion: (() -> Void)? = nil) {
    present(viewControllerToPresent, animated: flag, completion: completion)
  }
}
