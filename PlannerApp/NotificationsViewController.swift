//
//  NotificationsViewController.swift
//  PlannerApp
//
//  Created by Jia Jakubiec on 3/7/24.
//

//import UIKit
//
//class NotificationViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { _, _ in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                self.scheduleNotification()
//            }
//        }
//        scheduleNotification()
//    }
//    func scheduleNotification() {
//
//        let content = UNMutableNotificationContent()
//        content.title = "Notification!"
//        content.body = "Take a look at what needs to be done."
//        content.interruptionLevel = .timeSensitive
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: "time-sensitive-notif", content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print(error)
//            } else {
//                print("Success")
//            }
//        }
//    }
//}
