//
//  SceneDelegate.swift
//  PlannerApp
//
//  Created by Jia Jakubiec on 2/14/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate  {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else {return}
    }
//    func sceneDidDisconnect(_ scene: UIScene) {
//        
//    }
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        <#code#>
//    }
//    func sceneWillResignActive(_ scene: UIScene) {
//        <#code#>
//    }
//    func sceneWillEnterForeground(_ scene: UIScene) {
//        <#code#>
//    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        triggerLocalNotification(title: "Notification", body: "Reminder")
    }
}

extension SceneDelegate {
    private func triggerLocalNotification(title: String, body: String) {
        //notification content
        let content = UNMutableNotificationContent()
        content.body = body
        content.title = title
        content.sound = .default
        content.subtitle = "Something needs completion!"
        content.categoryIdentifier = "replyCategory"
        
        //notification action
        let replyAction = UNNotificationAction(identifier: "reply_action", title: "Reply", options: UNNotificationActionOptions.init(rawValue: 0))
            let actionCategory = UNNotificationCategory(identifier: "replyCategory", actions: [replyAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([actionCategory])
            
        //trigger notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        
        //create notification
        let localRequest = UNNotificationRequest(identifier: "local notification", content: content,trigger: trigger)
        
        //add notification
        UNUserNotificationCenter.current().add(localRequest) { (error) in
            if let error = error {
                print("Error", error.localizedDescription)
            } else {
                NSLog("Notification is scheduled.")
            }
            
        }
        
    }
}

