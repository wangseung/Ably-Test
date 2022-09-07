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
      .observe(on: MainScheduler.instance)
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.goods }
      .subscribe(onNext: { [weak self] goods in
        self?.setupContents(goods: goods)
      })
      .disposed(by: self.disposeBag)
    
    reactor.state.map { $0.goods.isLike }
      .skip(1) // 첫 로드할 때 제외하기..!
      .filter { $0 }
      .subscribe(onNext: { [weak self] _ in
        self?.increaseAndDecreaseAnimation()
      })
      .disposed(by: self.disposeBag)
    
    reactor.state.map { $0.goods.isLike }
      .map { $0 ? Image.heartFill : Image.heart }
      .bind(to: self.likeButton.rx.image(for: .normal))
      .disposed(by: self.disposeBag)
    
    reactor.state.map { $0.goods.isLike }
      .map { $0 ? UIColor.pointRed : UIColor.white }
      .bind(to: self.likeButton.rx.tintColor)
      .disposed(by: self.disposeBag)
  }
  
  
  // MARK: Animation
  
  private func increaseAndDecreaseAnimation() {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.1, animations: { [weak self] in
        self?.likeButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
      }, completion: { [weak self] _ in
        UIView.animate(withDuration: 0.1) { [weak self] in
          self?.likeButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { [weak self] _ in
          UIView.animate(withDuration: 0.2) { [weak self] in
            self?.likeButton.transform = CGAffineTransform.identity
          }
        }
      })
    }
  }
}
