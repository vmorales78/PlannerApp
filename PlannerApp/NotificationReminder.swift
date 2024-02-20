//
//  NotificationReminder.swift
//  PlannerApp
//
//  Created by Jia Jakubiec on 2/14/24.
//

import UIKit

//@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        usernotificationConfig()
        return true
    }
    func application(_ application: UIApplication, configureForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        //
    }
}

extension AppDelegate {
    private func usernotificationConfig() {
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .sound]){
            (isApproved, error) in
            if isApproved {
                print("User Notification: Approved")
                UNUserNotificationCenter.current().delegate = self
            } else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func notificationSnooze() {
        let snoozeButton = UNNotificationAction(identifier: "snooze", title: "Snooze", options: .init(rawValue: 0))
        let snoozeCategory = UNNotificationCategory(identifier: "snooze_category", actions: [snoozeButton], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([snoozeCategory])
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping() -> Void) {
        print("Usernotification didReceive: \(response)")
        completionHandler()
    }
}

