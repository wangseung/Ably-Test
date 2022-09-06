//
//  Bundle+Extension.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import Foundation

enum BundleKey: String {
  case apiURL = "API_URL"
}

extension Bundle {
  static func value(for key: String) -> String? {
    return self.main.infoDictionary?[key] as? String
  }
  
  static func value(for key: BundleKey) -> String? {
    return self.value(for: key.rawValue)
  }
}
