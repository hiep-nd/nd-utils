//
//  UIView+NDUtils.swift
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

extension UIView {
  @available(iOS 10.0, *)
  @inlinable
  public func nd_shake(
    in duration: TimeInterval = 0.5, translation: CGPoint = .init(x: 10, y: 0)
  ) {
    __nd_shake(withDuration: duration, translation: translation)
  }

  @inlinable
  @discardableResult
  public func nd_enableSeparator(
    heigth: CGFloat = 1, leading: CGFloat = 16, trailing: CGFloat = 16, color: UIColor
  ) -> UIView {
    return self.__nd_enableSeparator(withHeight: heigth, leading: leading, trailing: trailing, color: color)
  }
}
