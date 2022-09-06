//
//  GoodsCell.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/07.
//

import UIKit

import ReactorKit

class GoodsCell: BaseCollectionViewCell, ReactorKit.View {
  typealias Reactor = GoodsCellReactor
  
  // MARK: Constants
  
  enum Image {
    static let heart = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
    static let heartFill = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
  }
  
  
  // MARK: UI Components
  
  private let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.layer.cornerRadius = 4
    $0.clipsToBounds = true
    $0.backgroundColor = .red
  }
  
  let likeButton = UIButton().then {
    $0.tintColor = .white
    $0.setImage(Image.heart, for: .normal)
    $0.setImage(Image.heartFill, for: .selected)
    
    $0.imageView?.layer.shadowColor = UIColor.black.cgColor
    $0.imageView?.layer.shadowOpacity = 0.3
    $0.imageView?.layer.shadowRadius = 1
    $0.imageView?.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
    $0.imageView?.layer.shadowPath = nil
  }
  
  private let discountLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
    $0.textColor = .pointRed
  }
  
  private let priceLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
    $0.textColor = .textPrimary
  }
  
  private let priceStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 6
  }
  
  private let nameLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 13, weight: .regular)
    $0.textColor = .textSecondary
    $0.numberOfLines = 0
  }
  
  private let newLabel = PaddingLabel().then {
    $0.text = "NEW"
    $0.font = .systemFont(ofSize: 9, weight: .medium)
    $0.textColor = .textDarkGray
    $0.layer.borderColor = UIColor.textSecondary.cgColor
    $0.layer.borderWidth = 0.5
    $0.layer.cornerRadius = 2
    $0.padding = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
  }
  
  private let sellCountLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 11, weight: .regular)
    $0.textColor = .textSecondary
  }
  
  private let bottomLabelStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 4
  }
  
  private let contentStackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .leading
    $0.spacing = 12
  }
  
  private let separateLineView = UIView().then {
    $0.backgroundColor = .black.withAlphaComponent(0.1)
  }
  
  // MARK: Intialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
   
    self.setupViews()
    self.setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: Setup Views
  
  func setupViews() {
    self.contentView.addSubview(self.imageView)
    self.contentView.addSubview(self.likeButton)
    self.priceStackView.addArrangedSubview(self.discountLabel)
    self.priceStackView.addArrangedSubview(self.priceLabel)
    self.contentView.addSubview(self.priceStackView)
    self.bottomLabelStackView.addArrangedSubview(self.newLabel)
    self.bottomLabelStackView.addArrangedSubview(self.sellCountLabel)
    self.contentStackView.addArrangedSubview(self.nameLabel)
    self.contentStackView.addArrangedSubview(self.bottomLabelStackView)
    self.contentView.addSubview(self.contentStackView)
    self.contentView.addSubview(self.separateLineView)
  }
  
  
  // MARK: Layout
  
  func setupConstraints() {
    self.imageView.snp.makeConstraints {
      $0.top.leading.equalTo(18)
      $0.size.equalTo(80)
    }
    
    self.likeButton.snp.makeConstraints {
      $0.top.equalTo(self.imageView).inset(4)
      $0.trailing.equalTo(self.imageView).inset(4)
      $0.size.equalTo(30)
    }
    
    self.priceStackView.snp.makeConstraints {
      $0.top.equalTo(22)
      $0.leading.equalTo(self.imageView.snp.trailing).offset(10)
      $0.trailing.lessThanOrEqualToSuperview().inset(28)
    }
    
    self.contentStackView.snp.makeConstraints {
      $0.top.equalTo(self.priceStackView.snp.bottom).offset(2)
      $0.leading.equalTo(self.imageView.snp.trailing).offset(10)
      $0.trailing.equalToSuperview().inset(28)
      $0.bottom.equalToSuperview().inset(25)
    }
    
    self.separateLineView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.height.equalTo(1)
    }
  }
  
  
  // MARK: Binding
  
  func bind(reactor: GoodsCellReactor) {
    reactor.state.map { $0.goods }
      .subscribe { [weak self] goods in
        self?.setupContents(goods: goods)
      }
      .disposed(by: disposeBag)
  }
  
  
  // MARK: Configure
  
  func setupContents(goods: Goods) {
    self.imageView.sd_setImage(with: goods.imageURL)
    let ratio = self.calcDiscountRateString(
      price: goods.price,
      actualPrice: goods.actualPrice
    )
    self.discountLabel.text = "\(ratio)%"
    self.discountLabel.isHidden = ratio < 1
    self.priceLabel.text = goods.actualPrice.withCommas()
    self.nameLabel.text = goods.name
    self.sellCountLabel.text = "\(goods.sellCount.withCommas())개 구매중"
    self.sellCountLabel.isHidden = goods.sellCount < 10
  }
  
  func calcDiscountRateString(price: Int, actualPrice: Int) -> Int {
    let ratio = Double(actualPrice - price) / Double(actualPrice) * 100
    return Int(ratio)
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct GoodsCell_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    UIViewPreview {
      let cell = GoodsCell()
      cell.reactor = GoodsCellReactor(goods: Goods(id: 1, name: "asdfasfsasdfasfsasdfasfsasdfasfsasdfasfsasdfasfsasdfasfs", image: "https://d20s70j9gw443i.cloudfront.net/t_GOODS_THUMB_WEBP/https://imgb.a-bly.com/data/goods/20210316_1615852067467901s.jpg", actualPrice: 2000, price: 1800, isNew: true, sellCount: 80))
      return cell
    }
    .frame(maxHeight: 160, alignment: .topLeading)
    .previewLayout(.sizeThatFits)

  }
}

#endif
