//
//  MainTabBarController.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

final class MainTabBarController: UITabBarController {
  
  // MARK: Intialize
  
  init(
    homeViewController: HomeViewController,
    wishListViewController: WishListViewController
  ) {
    super.init(nibName: nil, bundle: nil)
    
    self.viewControllers = [
      homeViewController,
      wishListViewController
    ]
    .map { viewController -> UINavigationController in
      UINavigationController(rootViewController: viewController)
    }
    
    self.setupColors()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupColors() {
    self.tabBar.tintColor = UIColor.pointRed
    self.tabBar.unselectedItemTintColor = UIColor.textSecondary
  }
  
  func changeTab(index: Int) {
    self.selectedIndex = index
  }
}
