//
//  Extension.swift
//  WeatherApp
//
//  Created by Hieu on 17/03/2023.
//

import Foundation

extension Date {
    func formatAsAbbreviatedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    
    func formatAsAbbreviatedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: self)
    }
    
    func formatAsAbbreviatedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
