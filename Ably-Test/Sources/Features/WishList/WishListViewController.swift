//
//  WishListViewController.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import UIKit
import SwiftUI

import SnapKit
import ReactorKit
import RxDataSources

final class WishListViewController: BaseViewController, ReactorKit.View {
  typealias Reactor = WishListViewReactor
  typealias DataSource = RxCollectionViewSectionedReloadDataSource<WishListSection>
  
  
  // MARK: Constants
  
  private enum ReuseIdentifier {
    static let goods = "GoodsCell"
  }
  
  
  // MARK: UI Components
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    $0.backgroundColor = .clear
    $0.register(WishListGoodsCell.self, forCellWithReuseIdentifier: ReuseIdentifier.goods)
  }
  
  private lazy var emptyView = WishListEmptyView { [weak self] in
    self?.moveToHome?()
  }
  
  private lazy var emptyViewHosting = UIHostingController(rootView: self.emptyView)
  
  
  // MARK: Properties
  
  var dataSource: DataSource!
  var moveToHome: (() -> Void)? = nil
  
  
  // MARK: Intiailze
  
  init(reactor: Reactor) {
    defer { self.reactor = reactor }
    super.init()
    
    self.title = "좋아요"
    self.setupTabBarItem()
    self.setupCollectionView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .background
    
    self.view.addSubview(self.collectionView)
    self.view.addSubview(self.emptyViewHosting.view)
    self.emptyViewHosting.didMove(toParent: self)
  }
  
  
  // MARK: Layout
  
  override func setupConstraints() {
    self.collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.emptyViewHosting.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  
  // MARK: Binding
  
  func bind(reactor: WishListViewReactor) {
    reactor.state.map { $0.sections }
      .distinctUntilChanged()
      .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
    
    reactor.state.map { $0.wishListGoods.count }
      .map { $0 > 0 }
      .bind(to: self.emptyViewHosting.view.rx.isHidden)
      .disposed(by: self.disposeBag)
    
    self.rx.viewDidLoad
      .map { Reactor.Action.load }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
  
  
  // MARK: Tab Bar Item
  
  func setupTabBarItem() {
    let configuration = UIImage.SymbolConfiguration(pointSize: 14)
    self.tabBarItem.image = UIImage(
      systemName: "heart",
      withConfiguration: configuration
    )?.withRenderingMode(.alwaysTemplate)
    self.tabBarItem.selectedImage = UIImage(
      systemName: "heart.fill",
      withConfiguration: configuration
    )?.withRenderingMode(.alwaysTemplate)
  }
  
  
  // MARK: Setup CollectionView
  
  private func setupCollectionView() {
    self.dataSource = DataSource(configureCell: { dataSource, collectionView, indexPath, item in
      switch item {
      case .goods(let goodsCellReactor):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.goods, for: indexPath) as! WishListGoodsCell
        cell.reactor = goodsCellReactor
        return cell
      }
    })
    self.collectionView.collectionViewLayout = self.collectionViewLayout()
  }
}

extension WishListViewController {
  func collectionViewLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(160)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(160)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: item,
      count: 1
    )
    
    let section = NSCollectionLayoutSection(group: group)
    return UICollectionViewCompositionalLayout(section: section)
  }
}
