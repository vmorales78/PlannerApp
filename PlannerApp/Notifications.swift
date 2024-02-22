//
//  Notifications.swift
//  PlannerApp
//
//  Created by Jia Jakubiec on 2/6/24.
//

//import UIKit
//import UserNotifications
//
////@UIApplicationMain
//class AppDelegate: UIResponder {
//    var window: UIWindow?
//}
//
//extension AppDelegate: UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, _ in
//            guard granted else { return }
//            DispatchQueue.main.async {
//                application.registerForRemoteNotifications()
//            }
//        }
//        return true
//    }
//    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let token = deviceToken.reduce("") { $0 + String(format: "%02x", $1) }
//        print(token)
//    }
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        completionHandler()
//    }
//
//}

