//
//  CommonExtension.swift
//  DateGeoHistory
//
//  Created by JUNO on 2022/08/15.
//

import Foundation

public extension Date {
    
    func getStrDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        return dateFormatter.string(from: self)
    }
    
    func getStrDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func getStrMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월"
        
        return dateFormatter.string(from: self)
    }
    
    func getFirstDayOfMonth() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .hour, .minute], from: self)

        return calendar.date(from: components)!
    }
    
    func getLastDayOfMonth() -> Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: self.getFirstDayOfMonth())!
    }
    
    func getPrevMonth() -> Date {
        var components = DateComponents()
        components.month = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: self.getFirstDayOfMonth())!
    }
    
    func getNextMonth() -> Date {
        var components = DateComponents()
        components.month = 2
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: self.getFirstDayOfMonth())!
        
    }
}
