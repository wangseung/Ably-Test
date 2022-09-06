//
//  HomeViewController.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

import SnapKit

final class HomeViewController: BaseViewController {
  
  // MARK: UI Components
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
  
  override init() {
    super.init()
    
    self.title = NSLocalizedString("홈", comment: "home_controller_title")
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
  
  
  // MARK: Tab Bar Item
  
  func setupTabBarItem() {
    self.tabBarItem.image = UIImage(systemName: "house")?.withRenderingMode(.alwaysTemplate)
    self.tabBarItem.selectedImage = UIImage(named: "house.fill")?.withRenderingMode(.alwaysTemplate)
  }
  
  
  // MARK: Setup CollectionView
  
  private func setupCollectionView() {
    // TODO: DataSource 설정
    self.collectionView.collectionViewLayout = listLayout()
  }
  
  private func listLayout() -> UICollectionViewCompositionalLayout {
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
    listConfiguration.backgroundColor = .clear
    
    return UICollectionViewCompositionalLayout.list(using: listConfiguration)
  }
}
