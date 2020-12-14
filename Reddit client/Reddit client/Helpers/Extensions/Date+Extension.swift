//
//  Date+Extension.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/12/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

extension Date {
    
    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute], from: self, to: Date())
        if let year = interval.year, year > 0 {
            return "year count ago".localized(with: year)
        } else if let month = interval.month, month > 0 {
            return "month count ago".localized(with: month)
        } else if let week = interval.weekOfMonth, week > 0 {
            return "week count ago".localized(with: week)
        } else if let day = interval.day, day > 0 {
            return "day count ago".localized(with: day)
        } else if let hour = interval.hour, hour > 0 {
            return "hour count ago".localized(with: hour)
        } else if let minute = interval.minute, minute > 0 {
            return "minute count ago".localized(with: minute)
        } else {
            return "a moment ago"
        }
    }
    
}

