//
//  String+.swift
//  DateGeoHistory
//
//  Created by JUNO on 2022/08/15.
//

import Foundation

public extension String {
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
