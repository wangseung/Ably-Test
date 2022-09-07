//
//  WishListGoodsCell.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import ReactorKit

final class WishListGoodsCell: GoodsCell, ReactorKit.View {
  typealias Reactor = WishListGoodsCellReactor
  
  override func setupViews() {
    super.setupViews()
    
    self.likeButton.isHidden = true
  }
  
  func bind(reactor: WishListGoodsCellReactor) {
    reactor.state.map { $0.goods }
      .subscribe(onNext: { [weak self] goods in
        self?.setupContents(goods: goods)
      })
      .disposed(by: self.disposeBag)
  }
}
