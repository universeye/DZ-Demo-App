//
//  HomeTabBarVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/6.
//

import UIKit

class HomeTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [createLogoVC(), createWKWebViewVC()]
    }
    
    func createLogoVC() -> UINavigationController {
        let logoVC = LogoVC()
        logoVC.title = "Logo"
        logoVC.tabBarItem.image = UIImage(systemName: "house")
        
        return UINavigationController(rootViewController: logoVC)
    }
    
    //safari
    
    func createWKWebViewVC() -> UINavigationController {
        let webVC = WKWebVC()
        webVC.title = "Web"
        webVC.tabBarItem.image = UIImage(systemName: "safari")
        
        return UINavigationController(rootViewController: webVC)
    }

}
