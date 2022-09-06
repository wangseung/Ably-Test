//
//  Int+Extension.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import Foundation

extension Int {
  func withCommas() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.decimal
    return numberFormatter.string(from: NSNumber(value:self))!
  }
}
