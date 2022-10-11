//
//  MainNavigationController.swift
//  WanAndroidSwift
//  
//  Created by CoderSamz on 2022.
// 	
// 
    

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            navigationBar.scrollEdgeAppearance = barAppearance
            navigationBar.standardAppearance = barAppearance
        }
    }

}
