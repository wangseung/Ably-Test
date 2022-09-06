//
//  BannerCell.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

import Then
import SDWebImage
import ReactorKit

final class BannerCell: BasePagerViewCell, ReactorKit.View {
  typealias Reactor = BannerCellReactor
  
  // MARK: UI Components
  
  private let coverImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .textSecondary
  }
  

  // MARK: Intiailze

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.addSubview(coverImageView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.coverImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  
  // MARK: Binding
  
  func bind(reactor: BannerCellReactor) {
    reactor.state.map { $0.banner }
      .subscribe(on: MainScheduler.asyncInstance)
      .subscribe(onNext: { [weak self] banner in
        guard let self = self else { return }
        self.coverImageView.sd_imageTransition = .fade
        self.coverImageView.sd_setImage(with: banner.imageURL)
      })
      .disposed(by: disposeBag)
  }
}
