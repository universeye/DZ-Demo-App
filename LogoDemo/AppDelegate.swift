//
//  AppDelegate.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/6.
//

import UIKit
import UserNotifications
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //launch screen -> custum navbar title -> floatingButton rotation -> tabview for screens -> uianimation -> uicollection -> CoreData for main page
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        for family in UIFont.familyNames.sorted() {
        //            let _ = UIFont.fontNames(forFamilyName: family)
        //            //print("Family: \(family) Font names: \(names)")
        //        }
        IQKeyboardManager.shared.enable = false
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
        }
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var tokenString = ""
        for byte in deviceToken {
            let hexString = String(format: "%02x", byte)
            tokenString += hexString
        }
        print("tokenString is \(tokenString)")
    }
    
    
}

