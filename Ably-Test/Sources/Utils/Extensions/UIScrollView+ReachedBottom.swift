//
//  UIScrollView+ReachedBottom.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import UIKit

import RxSwift
import RxCocoa

extension UIScrollView {
  var isOverflowVertical: Bool {
    return self.contentSize.height > self.frame.height && self.frame.height > 0
  }
  
  func isReachedBottom(withTolerance tolerance: CGFloat = 0) -> Bool {
    guard self.isOverflowVertical else { return false }
    let contentOffsetBottom = self.contentOffset.y + self.frame.height
    return contentOffsetBottom >= self.contentSize.height - tolerance
  }
}

extension Reactive where Base: UIScrollView {
  var isReachedBottom: ControlEvent<Void> {
    let source = self.contentOffset
      .filter { [weak base = self.base] offset in
        guard let base = base else { return false }
        return base.isReachedBottom(withTolerance: base.frame.height / 2)
      }
      .map { _ in Void() }
    return ControlEvent(events: source)
  }
}
