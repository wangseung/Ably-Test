//
//  HomeGoodsCell.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

final class HomeGoodsCell: GoodsCell, ReactorKit.View {
  
  typealias Reactor = HomeGoodsCellReactor
  
  
  // MARK: Binding
  
  func bind(reactor: Reactor) {
    self.likeButton.rx.tap
      .map { Reactor.Action.toggleLike }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.goods }
      .subscribe(onNext: { [weak self] goods in
        self?.setupContents(goods: goods)
      })
      .disposed(by: self.disposeBag)
    
    reactor.state.map { $0.isLiked }
      .filter { $0 }
      .subscribe(onNext: { [weak self] _ in
        self?.increaseAndDecreaseAnimation()
      })
      .disposed(by: self.disposeBag)
    
    reactor.state.map { $0.isLiked }
      .map { $0 ? Image.heartFill : Image.heart }
      .bind(to: self.likeButton.rx.image(for: .normal))
      .disposed(by: self.disposeBag)
    
    reactor.state.map { $0.isLiked }
      .map { $0 ? UIColor.pointRed : UIColor.white }
      .bind(to: self.likeButton.rx.tintColor)
      .disposed(by: self.disposeBag)
  }
  
  
  // MARK: Animation
  
  private func increaseAndDecreaseAnimation() {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.2) { [weak self] in
        self?.likeButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
      } completion: { [weak self] _ in
        UIView.animate(withDuration: 0.2) { [weak self] in
          self?.likeButton.transform = CGAffineTransform.identity
        }
      }
    }
  }
}