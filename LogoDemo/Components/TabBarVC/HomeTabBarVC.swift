//
//  HomeTabBarVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/6.
//

import UIKit
import SwiftUI
import Combine

class HomeTabBarVC: UITabBarController {
    
    var cancellableL: AnyCancellable!
    let delegates = ContentViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        }
        UITabBar.appearance().tintColor = UIColor(named: "AppPurple")
        viewControllers = [createLogoVC(), createPickerViewVC(), createAnimationVC(), createNewButtonVC() , createWidgetVC()]
        
    }
    
    func showCoverScreen() {
        let onBoardView = UIHostingController(rootView: OnBoardingView(delegate: delegates))
        onBoardView.modalTransitionStyle = .crossDissolve
        onBoardView.modalPresentationStyle = .overFullScreen
        present(onBoardView, animated: true)
        
        self.cancellableL = delegates.$isDismiss.sink { status in
            if status == true {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func createLogoVC() -> UINavigationController {
        let logoVC = LogoVC()
        logoVC.title = "Logo"
        logoVC.tabBarItem.image = UIImage(systemName: "house")
        
        return UINavigationController(rootViewController: logoVC)
    }
    
    //safari
    
    func createPickerViewVC() -> UINavigationController {
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
    
    func createNewButtonVC() -> UINavigationController {
        let newButtonVC = NewButtonsVC()
        newButtonVC.title = "Buttons"
        
        newButtonVC.tabBarItem.image = UIImage(systemName: "hand.tap.fill")
        
        return UINavigationController(rootViewController: newButtonVC)
    }
    
}
