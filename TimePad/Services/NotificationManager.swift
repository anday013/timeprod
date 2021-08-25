//
//  NotificationManager.swift
//  TimePad
//
//  Created by Anday on 24.08.21.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("NOTIFICATION ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    private func scheduleNotification(title: String, subtitle: String, badge: NSNumber, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        content.badge = badge
        
        let dateComponents = Calendar.current.dateComponents([.minute, .hour, .day, .month, .year], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func scheduleTaskNotification(task: Task) {
        scheduleNotification(title: "\(task.title) is waiting for you...", subtitle: "Do not miss your task", badge: 1, date: task.date)
    }
}
