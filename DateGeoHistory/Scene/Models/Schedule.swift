//
//  Date.swift
//  DateGeoHistory
//
//  Created by JUNO on 2022/08/14.
//

import Foundation
import RealmSwift

class Schedule: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Date
    @Persisted var title: String
    @Persisted var memo: String
    
    convenience init(date: Date, title: String, memo: String) {
        self.init()
        self.date = date
        self.title = title
        self.memo = memo
    }
}
