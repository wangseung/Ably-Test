//
//  HomeViewController.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

import SnapKit
import ReactorKit
import RxDataSources

final class HomeViewController: BaseViewController, ReactorKit.View {
  typealias Reactor = HomeViewReactor
  typealias DataSource = RxCollectionViewSectionedReloadDataSource<HomeViewSection>
  
  // MARK: Constants
  
  private enum ReuseIdentifier {
    static let bannerContainer = "BannerContainerCell"
    static let goods = "GoodsCell"
  }
  
  
  // MARK: UI Components
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    $0.register(BannerContainerCell.self, forCellWithReuseIdentifier: ReuseIdentifier.bannerContainer)
    $0.register(GoodsCell.self, forCellWithReuseIdentifier: ReuseIdentifier.goods)
  }
  
  
  // MARK: Properties
  
  var dataSource: DataSource!
  
  
  // MARK: Intialize
  
  init(reactor: Reactor) {
    defer { self.reactor = reactor }
    
    super.init()
    
    self.title = "홈"
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
  }
  
  
  // MARK: Layout
  
  override func setupConstraints() {
    self.collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  
  // MARK: Binding
  
  func bind(reactor: HomeViewReactor) {
    self.rx.viewDidLoad
      .map { Reactor.Action.load }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.sections }
      .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
  }
  
  
  // MARK: Tab Bar Item
  
  func setupTabBarItem() {
    self.tabBarItem.image = UIImage(systemName: "house")?.withRenderingMode(.alwaysTemplate)
    self.tabBarItem.selectedImage = UIImage(named: "house.fill")?.withRenderingMode(.alwaysTemplate)
  }
  
  
  // MARK: Setup CollectionView
  
  private func setupCollectionView() {
    self.dataSource = DataSource(configureCell: { dataSource, collectionView, indexPath, item in
      switch item {
      case .banner(let bannerContainerCellReactor):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.bannerContainer, for: indexPath) as! BannerContainerCell
        cell.reactor = bannerContainerCellReactor
        return cell
      case .goods(let goodsCellReactor):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.goods, for: indexPath) as! GoodsCell
        cell.reactor = goodsCellReactor
        return cell
      }
    })
    self.collectionView.collectionViewLayout = self.collectionViewLayout()
  }
}
