//
//  PaddingLabel.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

class PaddingLabel: UILabel {
  var padding: UIEdgeInsets = .zero
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: padding))
  }
  
  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(
      width: size.width + padding.left + padding.right,
      height: size.height + padding.top + padding.bottom
    )
  }
}
