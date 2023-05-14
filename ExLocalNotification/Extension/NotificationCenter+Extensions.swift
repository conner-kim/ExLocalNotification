//
//  NotificationCenter+Extensions.swift
//  ReserveNotification
//
//  Created by Conner on 2023/03/22.
//

import Foundation
import UserNotifications


extension UNUserNotificationCenter {
    
    /// 푸시 즉시 전송 - 커스텀 액션 추가
    func sendPusnCustomAction(title: String, body: String) {
        
        // Category 설정
        let actions = NotificationActionType.allCases.map({ $0.toAction() })
        let checkCategory = UNNotificationCategory(
            identifier: NotificationCategoryType.check.rawValue,
            actions: actions,
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction)
        
        self.setNotificationCategories([checkCategory])
        
        
        // Content 생성
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.sound = .default
        notificationContent.userInfo = ["TAKE_MEDICINE_ID": Int.random(in: (12345...54321))]
        notificationContent.categoryIdentifier = NotificationCategoryType.check.rawValue
        
        // Request 생성
        let request = UNNotificationRequest(
            identifier: NotificationRequestType.bloodTypeCheck.rawValue,
            content: notificationContent,
            trigger: nil
        )
        
        // 로컬 알림 등록
        self.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    /// 푸시 즉시 전송
    func sendPush(title: String, body: String) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.sound = .default
        notificationContent.userInfo = ["SCREEN": "PUSH_LIST"]
        
        let request = UNNotificationRequest(
            identifier: NotificationRequestType.bloodTypeCheck.rawValue,
            content: notificationContent,
            trigger: nil
        )
        
        self.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    /// 푸시 예약 발송
    /// 최소 단위 분
    func sendPushReservation(title: String, body: String, date: Date) {
        // content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        // STEP 2 : Specify the Conditions for Delivery
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_kr")
        
        let component = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
        
        // 전송
        let requestID = String(describing: Int(date.timeIntervalSince1970))
        let request = UNNotificationRequest(identifier: requestID, content: content, trigger: trigger)

        self.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
            print("푸시 예약 완료")
        }
    }
}
