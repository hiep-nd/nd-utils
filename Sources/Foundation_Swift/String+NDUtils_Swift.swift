//
//  String+NDUtils_Swift.swift
//  NDUtils_Swift
//
//  Created by Nguyen Duc Hiep on 6/25/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

extension String {
  @inlinable
  public static func nd_(named: String) -> Self {
    return Self(NSString.nd_(named: named))
  }

  @inlinable
  public func nd_contains(regexPattern: String) -> Bool {
    NSString(string: self).nd_contains(regexPattern: regexPattern)
  }

  @inlinable
  public func nd_matchs(regexPattern: String) -> Bool {
    NSString(string: self).nd_matchs(regexPattern: regexPattern)
  }
}
