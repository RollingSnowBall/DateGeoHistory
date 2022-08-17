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
}
