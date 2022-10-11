//
//  MainTabBarController.swift
//  WanAndroidSwift
//  
//  Created by CoderSamz on 2022.
// 	
// 
    

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15, *) {
            let barAppearance = UITabBarAppearance()
            barAppearance.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            tabBar.scrollEdgeAppearance = barAppearance
            tabBar.standardAppearance = barAppearance
        }

        setupChildViewController()
        /**
         */
    }
    

    func setupChildViewController() {
        let viewsStoryboard = UIStoryboard(name: "Views", bundle: nil)
        // 首页
        let homeVC = viewsStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        homeVC.view.backgroundColor = .white
        homeVC.tabBarItem.image = UIImage(named: "smile")
        homeVC.tabBarItem.selectedImage = UIImage(named: "smile")
        addChild(homeVC)
        
        // 我的
        let mineVC = viewsStoryboard.instantiateViewController(withIdentifier: "MineViewController")
        mineVC.view.backgroundColor = .white
        mineVC.tabBarItem.image = UIImage(named: "tools")
        mineVC.tabBarItem.selectedImage = UIImage(named: "tools")
        addChild(mineVC)
    }

    func randomColor() -> UIColor {
        let  red =  CGFloat (arc4random()%256)/255.0
        let  green =  CGFloat (arc4random()%256)/255.0
        let  blue =  CGFloat (arc4random()%256)/255.0
        return UIColor (red: red, green: green, blue: blue, alpha: 1.0)
    }
}
