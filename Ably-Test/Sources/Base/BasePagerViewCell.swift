//
//  BasePagerViewCell.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

import RxSwift
import FSPagerView

class BasePagerViewCell: FSPagerViewCell {
  
  // MARK: Properties
  
  var disposeBag = DisposeBag()

  
  // MARK: Initialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: .zero)
  }
}
