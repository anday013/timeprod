//
//  Date.swift
//  TimePad
//
//  Created by Anday on 15.08.21.
//

import Foundation

extension Date {
    
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    var last7days: [Int] {
        return (1...7).map {
            adding(days: -$0).day
        }
    }
    func near(days: Int) -> [Int] {
        return days == 0 ? [day] : (1...abs(days)).map {
            adding(days: $0 * (days < 0 ? -1 : 1) ).day
        }
    }
}
