//
//  ViewController.swift
//  PlannerApp
//
//  Created by Jia Jakubiec on 2/26/24.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForPermission()
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.schedule()
        }
    }
    
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .denied:
                return
            case .authorized:
                self.dispatchNotification()
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
            default:
                return
            }
        }
    }
    
    func schedule() {
        let content = UNMutableNotificationContent()
        content.title = "Notification"
        content.body = "Check assignments"
        content.interruptionLevel = .timeSensitive
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "time_sensitive", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            } else {
                print("Success")
            }
        }
    }
    
    func dispatchNotification() {
        let identifier = "my-notification"
        let title = "Reminder!"
        let body = "You have something in need of completion."
        let hour = 11
        let minute = 10
        let isDaily = false
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponent = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponent.hour = hour
        dateComponent.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
    
//    @IBAction func action(_ sender: Any) {
//        let content = UNMutableNotificationContent()
//        content.title = "Assignment!"
//        content.subtitle = "You have something in need of completion."
//        content.body = "Check your tasks."
//        content.badge = 1
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: "notifDone", content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
