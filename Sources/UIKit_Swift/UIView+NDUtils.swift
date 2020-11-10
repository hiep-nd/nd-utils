//
//  UIView+NDUtils.swift
//  NDUtils_Swift
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

extension UIView {
  @available(iOS 10.0, *)
  public func nd_shake(
    in duration: TimeInterval = 0.5, translation: CGPoint = .init(x: 10, y: 0)
  ) {
    __nd_shake(withDuration: duration, translation: translation)
  }
}
