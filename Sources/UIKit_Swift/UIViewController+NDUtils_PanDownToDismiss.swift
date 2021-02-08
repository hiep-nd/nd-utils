//
//  UIViewController+NDUtils_SlideTransitioning.swift
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 05/01/2021.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

extension UIViewController {
  @inlinable
  public func nd_enablePanDownToDismiss(options: [NDUIViewControllerPanDownToDismissOptionsKey: Any]? = nil) {
    __nd_enablePanDownToDismiss(options: options)
  }
}
