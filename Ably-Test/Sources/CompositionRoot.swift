//
//  CompositionRoot.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

import SDWebImageWebPCoder

struct AppDependency {
  let window: UIWindow
}

final class CompositionRoot {
  static func resolve() -> AppDependency {
    let window = UIWindow()
    window.makeKeyAndVisible()
    
    SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
    
    let networking = AblyNetworing()
    let realmManager = RealmManager()
    let homeService = HomeService(networking: networking)
    let wishListService = WishListService(realmManager: realmManager)
    
    // Home
    let homeViewReactor = HomeViewReactor(
      homeService: homeService,
      wishListService: wishListService,
      homeGoodsCellReactorFactory: { goods -> HomeGoodsCellReactor in
        HomeGoodsCellReactor(goods: goods, wishListService: wishListService)
      }
    )
    let homeViewController = HomeViewController(
      reactor: homeViewReactor
    )
    
    // WishList
    let wishListViewReactor = WishListViewReactor(
      wishListService: wishListService) { goods -> WishListGoodsCellReactor in
        WishListGoodsCellReactor(goods: goods)
      }
    let wishListViewController = WishListViewController(
      reactor: wishListViewReactor
    )
    
    // MainTabBar
    let mainTabBarController = MainTabBarController(
      homeViewController: homeViewController,
      wishListViewController: wishListViewController
    )
    
    wishListViewController.moveToHome = { [weak mainTabBarController] in
      mainTabBarController?.changeTab(index: 0)
    }
    
    window.rootViewController = mainTabBarController
    
    return AppDependency(
      window: window
    )
  }
}
