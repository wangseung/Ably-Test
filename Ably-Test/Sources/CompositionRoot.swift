//
//  CompositionRoot.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

struct AppDependency {
  let window: UIWindow
}

final class CompositionRoot {
  static func resolve(windowScene: UIWindowScene) -> AppDependency {
    let window = UIWindow(windowScene: windowScene)
    window.makeKeyAndVisible()
    
    let networking = AblyNetworing()
    let realmManager = RealmManager()
    let homeService = HomeService(networking: networking)
    let wishListService = WishListService(realmManager: realmManager)
    
    let homeViewReactor = HomeViewReactor(
      homeService: homeService,
      wishListService: wishListService,
      homeGoodsCellReactorFactory: { goods -> HomeGoodsCellReactor in
        HomeGoodsCellReactor(goods: goods, wishListService: wishListService)
      }
    )
    let homeViewController = HomeViewController(reactor: homeViewReactor)
    
    let wishListViewReactor = WishListViewReactor(
      wishListService: wishListService) { goods -> WishListGoodsCellReactor in
        WishListGoodsCellReactor(goods: goods)
      }
    let wishListViewController = WishListViewController(reactor: wishListViewReactor)
    
    let mainTabBarController = MainTabBarController(
      homeViewController: homeViewController,
      wishListViewController: wishListViewController
    )
    window.rootViewController = mainTabBarController
    
    return AppDependency(
      window: window
    )
  }
}
