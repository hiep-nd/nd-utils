//
//  CATransaction+NDUtils.swift
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 8/10/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

public func nd_attach<Result>(
  toAnimation animation: () -> Result, completion: @escaping () -> Void
) -> Result {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var result: Result!
  NDUtils.nd_attach(
    toAnimation: {
      result = animation()
    }, completion: completion)
  return result
}
