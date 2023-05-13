//
//  Date+Extensions.swift
//  ReserveNotification
//
//  Created by Conner on 2023/03/22.
//

import Foundation

extension Date {
    func adding(_ component: Calendar.Component, _ value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    /// return: M.d h:m
    func formattedString() -> String {
        let format = DateFormatter()
        format.dateFormat = "M.d h:m"
        return format.string(from: self)
    }
}
