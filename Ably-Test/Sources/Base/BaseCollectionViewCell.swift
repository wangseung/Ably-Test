//
//  BaseCollectionViewCell.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
  
  // MARK: Properties
  
  var disposeBag = DisposeBag()
  
  
  // MARK: Prepare
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.disposeBag = DisposeBag()
  }
}
