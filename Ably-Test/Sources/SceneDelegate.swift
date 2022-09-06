//
//  SceneDelegate.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var dependency: AppDependency!
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    self.dependency = self.dependency ?? CompositionRoot.resolve(windowScene: windowScene)
    window = self.dependency.window
  }
}

