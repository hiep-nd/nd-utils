//
//  UIViewController+NDUtils_SlideTransitioning.swift
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 05/01/2021.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

extension UIViewController {
  @inlinable
  public func nd_enableSlideTransitioning(options: [NDUIViewControllerSlideTransitioningOptionsKey: Any]? = nil) {
    __nd_enableSlideTransitioning(options: options?.reduce(into: [:]) {
      switch $1.key {
      case .dockingEdge:
        $0?[$1.key] =
          ($1.value is UIRectEdge)
          // swiftlint:disable:next force_cast
          ? ($1.value as! UIRectEdge).rawValue : $1.value
      default:
        $0?[$1.key] = $1.value
      }
    })
  }
}
