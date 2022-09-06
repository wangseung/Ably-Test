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
    
    let homeViewController = HomeViewController()
    
    let mainTabBarController = MainTabBarController(
      homeViewController: homeViewController
    )
    window.rootViewController = mainTabBarController
    
    return AppDependency(
      window: window
    )
  }
}
