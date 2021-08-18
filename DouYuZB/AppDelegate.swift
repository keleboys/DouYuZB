//
//  AppDelegate.swift
//  DouYuZB
//
//  Created by 张泉 on 2021/8/17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UITabBar.appearance().tintColor = UIColor.orange
        self.window?.rootViewController = ZQMainViewController()
        self.window?.makeKeyAndVisible()
        return true
    }

}

