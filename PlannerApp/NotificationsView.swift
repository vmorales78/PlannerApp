//
//  NotificationsView.swift
//  PlannerApp
//
//  Created by Jia Jakubiec on 2/6/24.
//

//import Foundation
//import UIKit
//import UserNotifications
//
//class NotificationsView: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    func checkForPermission() {
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.getNotificationSettings { settings in
//            switch settings.authorizationStatus {
//            case .authorized:
//                self.dispatchNotification()
//            case .denied:
//                return
//            case .notDetermined:
//                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
//                    if didAllow {
//                        self.dispatchNotification()
//                    }
//                }
//            default:
//                return
//            }
//        }
//    }
//    
//    func dispatchNotification() {
//        let identifier = "my-notification"
//        let title = "Check Assignment!"
//        let body = "You have something due soon."
//        //let hour = 11
//        //let minute = 20
//        
//        let notificationCenter = UNUserNotificationCenter.current()
//        
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = body
//        content.sound = .default
//        
//        let calendar = Calendar.current
//        var dataComponents = DataComponents(calendar: calendar, timezone: TimeZone.current)
//        //dataComponents.hour = hour
//        //dataComponents.minute = minute
//        
//        let trigger = UNCalendarNotificationTrigger(coder: dataComponents)
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//        
//        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
//        notificationCenter.add(request)
//    }
//}
