//
//  UIScrollView+NDUtils.swift
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 11/01/2020.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

extension UIScrollView {
  @available(iOS 11.0, *)
  @inlinable
  public func nd_scrollToTop(animated: Bool = true) {
    self.__nd_scrollToTopWith(animated: animated)
  }
}
