//
//  Error+Foundation_Swift.swift
//  NDUtils
//
//  Created by Nguyen Duc Hiep on 17/11/2020.
//

import Foundation

@inlinable
public func nd_runtimeError(with message: String, tag: String? = nil, function: StaticString = #function, file: StaticString = #file, line: UInt = #line) -> NSError {
  return .__nd_runtimeError(
    withMessage: message,
    tag: tag,
    function: String(describing: function),
    file: String(describing: file),
    line: line
  )
}
