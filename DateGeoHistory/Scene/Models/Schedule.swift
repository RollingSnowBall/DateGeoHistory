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
    @Persisted var memo: String
    @Persisted var DetailList: List<ScheduleDetail>
    
    convenience init(date: Date, memo: String) {
        self.init()
        self.date = date
        self.memo = memo
    }
}

class ScheduleDetail: EmbeddedObject {
    @Persisted var order: Int
    @Persisted var title: String
    @Persisted var detail: String?
    
    convenience init(order: Int, title: String, detail: String) {
        self.init()
        self.order = order
        self.title = title
        self.detail = detail
    }
}
