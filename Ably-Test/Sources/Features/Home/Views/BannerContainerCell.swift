//
//  BannerContainerCell.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

import Then
import ReactorKit
import FSPagerView

final class BannerContainerCell: BaseCollectionViewCell, ReactorKit.View {
  
  typealias Reactor = BannerContainerCellReactor
  
  
  // MARK: Constants
  
  private enum ReuseIdentifier {
    static let banner = "BannerCell"
  }
  
  
  // MARK: UI Components
  
  private let pagerView = FSPagerView(frame: .zero).then {
    $0.automaticSlidingInterval = 5.0
    $0.isInfinite = true
    $0.register(BannerCell.self, forCellWithReuseIdentifier: ReuseIdentifier.banner)
  }
  
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
    
    self.pagerView.dataSource = self
    self.pagerView.delegate = self
    
    self.contentView.addSubview(self.pagerView)
    self.contentView.addSubview(self.indexLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.pagerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.indexLabel.snp.makeConstraints {
      $0.right.equalTo(-10)
      $0.bottom.equalTo(-10)
      $0.height.equalTo(24)
      $0.width.greaterThanOrEqualTo(48)
    }
  }
  
  
  // MARK: Binding
  
  func bind(reactor: Reactor) {
    reactor.state.map { $0.indexText }
      .observe(on: MainScheduler.asyncInstance)
      .bind(to: indexLabel.rx.text)
      .disposed(by: self.disposeBag)
  }
}

extension BannerContainerCell: FSPagerViewDataSource {
  func numberOfItems(in pagerView: FSPagerView) -> Int {
    return self.reactor?.currentState.banners.count ?? 0
  }
  
  func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
    let cell = pagerView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.banner, at: index) as! BannerCell
    guard let banners = self.reactor?.currentState.banners else { fatalError() }
    let bannerCellReactor = BannerCellReactor(banner: banners[index])
    cell.reactor = bannerCellReactor
    return cell
  }
}

extension BannerContainerCell: FSPagerViewDelegate {
  func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
    reactor?.action.onNext(.move(index: targetIndex))
  }
  
  func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
    reactor?.action.onNext(.move(index: pagerView.currentIndex))
  }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct BannerContainerCell_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    UIViewPreview {
      let cell = BannerContainerCell()
      cell.reactor = BannerContainerCellReactor(banners: [Banner(id: 1, image: "https://img.a-bly.com/banner/images/banner_image_1615465448476691.jpg")])
      return cell
    }
    .previewLayout(.fixed(width: 375, height: 262))
  }
}

#endif
