//
//  NotificationsAndFocusModesVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/11/12.
//

import UIKit
import UserNotifications

@available(iOS 15.0, *)
class NotificationsAndFocusModesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { _, _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.scheduleNotification()
            }
        }
        view.backgroundColor = .systemBackground
        
    }
    
    private func scheduleNotification() {
        //Content
        let content = UNMutableNotificationContent()
        content.title = "John Smith is live"
        content.body = "Go and Connect with John Smith in his video"
        content.interruptionLevel = UNNotificationInterruptionLevel.timeSensitive
        
        //Trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        //Request
        let request = UNNotificationRequest(identifier: "time_sensitive_example", content: content, trigger: trigger)
        
        //Schedule Request
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success")
            }
        }
    }

}
