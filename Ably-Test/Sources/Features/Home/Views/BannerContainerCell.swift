//
//  BannerContainerCell.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

import Then

final class BannerContainerCell: BaseCollectionViewCell {
  
  // MARK: UI Components
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
  
  private let indexLabel = PaddingLabel().then {
    $0.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    $0.textAlignment = .center
    $0.backgroundColor = .black.withAlphaComponent(0.3)
    $0.layer.cornerRadius = 12
    $0.clipsToBounds = true
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 12, weight: .light)
  }
  
  
  // MARK: Intialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.addSubview(collectionView)
    self.contentView.addSubview(indexLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.indexLabel.snp.makeConstraints {
      $0.right.equalTo(-10)
      $0.bottom.equalTo(-10)
      $0.height.equalTo(24)
      $0.width.greaterThanOrEqualTo(48)
    }
  }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct BannerContainerCell_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    UIViewPreview {
      return BannerContainerCell()
    }
    .previewLayout(.fixed(width: 375, height: 262))
  }
}

#endif
