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
    func dispatchNotification() {
        let identifier = "my-notification"
        let title = "Reminder!"
        let body = "You have something in need of completion."
        let hour = 11
        let minute = 16
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
}
