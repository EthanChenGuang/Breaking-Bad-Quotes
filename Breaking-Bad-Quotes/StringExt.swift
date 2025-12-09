//
//  StringExt.swift
//  Breaking-Bad-Quotes
//
//  Created by Guang on 2025/12/9.
//

import Foundation

extension String {
  func removeCaseAndSpace() -> String {
    return self.lowercased().replacingOccurrences(of: " ", with: "")
  }

  func removeSpaces() -> String {
    return self.replacingOccurrences(of: " ", with: "")
  }
}
