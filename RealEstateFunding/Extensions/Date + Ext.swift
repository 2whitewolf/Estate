//
//  Date + Ext.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 14.09.2023.
//

import Foundation
extension Date {
    var stringRepresentationOfYearMonthDay: String {
        let currentDate = self
        
        // Create a Calendar object to work with dates
        let calendar = Calendar.current
        
        // Extract the year and month from the Date
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        return "\(day) / \(month) / \(year)"
    }
}
