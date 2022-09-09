//
//  AppDelegate.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var dependency: AppDependency!
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.dependency = self.dependency ?? CompositionRoot.resolve()
    self.window = self.dependency.window
    
    return true
  }
}

