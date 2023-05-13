//
//  NotificationActionType.swift
//  ReserveNotification
//
//  Created by Conner on 2023/05/13.
//

import Foundation
import UserNotifications


enum NotificationActionType: String, CaseIterable {
    case taking = "ACTION_TAKING"
    case notTaking = "ACTION_NOT_TAKING"
}

extension NotificationActionType {
    func toString() -> String {
        switch self {
        case .taking:
            return "복용함"
        case .notTaking:
            return "복용안함"
        }
    }
    
    func toAction() -> UNNotificationAction {
        return UNNotificationAction(identifier: self.rawValue, title: self.toString(), options: [])
    }
}
