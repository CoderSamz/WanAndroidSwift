//
//  AppDelegate.swift
//  WanAndroidSwift
//  
//  Created by CoderSamz on 2022.
// 	
// 
    

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        //
        let mainNav = MainNavigationController(rootViewController: MainTabBarController())
        window?.rootViewController = mainNav
        window?.makeKeyAndVisible()
        return true
    }

}

