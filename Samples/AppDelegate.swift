//
//  AppDelegate.swift
//  Samples
//
//  Created by Nguyen Duc Hiep on 11/10/20.
//

import UIKit
import NDLog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    nd_configureLog(paras: [.level: NDLogLevel.all])

    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
    window.rootViewController = MenuViewController()
    window.makeKeyAndVisible()
    return true
  }
}
