//
//  main.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/08.
//

import UIKit

private func appDelegateClassName() -> String {
  return NSStringFromClass(NSClassFromString("Ably_TestTests.StubAppDelegate") ?? AppDelegate.self)
}

_ = UIApplicationMain(
  CommandLine.argc,
  CommandLine.unsafeArgv,
  nil,
  appDelegateClassName()
)
