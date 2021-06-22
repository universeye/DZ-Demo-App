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
        
        viewControllers = [createLogoVC(), createWKWebViewVC(), createAnimationVC(), createWidgetVC()]
    }
    
    func createLogoVC() -> UINavigationController {
        let logoVC = LogoVC()
        logoVC.title = "Logo"
        logoVC.tabBarItem.image = UIImage(systemName: "house")
        
        return UINavigationController(rootViewController: logoVC)
    }
    
    //safari
    
    func createWKWebViewVC() -> UINavigationController {
        let webVC = PickerVC()
        webVC.title = "Picker"
        webVC.tabBarItem.image = UIImage(systemName: "list.bullet.indent")
        
        return UINavigationController(rootViewController: webVC)
    }
    
    func createWidgetVC() -> UIViewController {
        let widgetVC = WidgetVC()
        widgetVC.title = "Widget"
        widgetVC.tabBarItem.image = UIImage(systemName: "rectangle.expand.vertical")
        
        return widgetVC
    }
    
    func createAnimationVC() -> UINavigationController {
        let animateVC = AnimationViewController()
        animateVC.title = "Animations"
        
        animateVC.tabBarItem.image = UIImage(named: "icons8")
        
        return UINavigationController(rootViewController: animateVC)
    }

}
