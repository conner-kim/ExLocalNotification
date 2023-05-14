//
//  NotificationActionType.swift
//  ReserveNotification
//
//  Created by Conner on 2023/05/13.
//

import Foundation
import UserNotifications


enum NotificationActionType: String, CaseIterable {
    case accept = "ACTION_ACCEPT"
    case decline = "ACTION_DECLINE"
}

extension NotificationActionType {
    func toString() -> String {
        switch self {
        case .accept:
            return "확인oo"
        case .decline:
            return "확인xx"
        }
    }
    
    func toAction() -> UNNotificationAction {
        return UNNotificationAction(identifier: self.rawValue, title: self.toString(), options: [])
    }
}
