//
//  Utility.swift
//  Weather
//
//  Created by Rambabu Murakonda on 8/21/24.
//

import Foundation

extension Int64 {
    func toDate() -> Date {
        return Date(timeIntervalSince1970: Double(self))
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm a"
        return formatter.string(from: self)
    }
}

extension Locale{
    var measurementSystem : String
    {
        guard let system = (self as NSLocale).object(forKey: NSLocale.Key.measurementSystem) as? String else {
            return "Kelvin"
        }
        return system == "U.S." ? "Imperial" : "Metric"
    }
    
    var tempUnits: String {
        return measurementSystem == "Imperial" ? "°F" : "°C"
    }
}
