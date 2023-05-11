//
//  QrData.swift
//  ex01
//
//  Created by jjglobal on 2023/04/27.
//
//import RealmSwift
//
//class QrData: Object {
//    // primary keys
//    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var value: String
//    @Persisted var date: String
//
//    // 선택 입력값은 optional 사용
//    @Persisted var type: String?
//
//    override init() {
//        super.init()
//        self.date = self.getCurretDateForString()
//    }
//
//    func getCurretDateForString() -> String {
//        let date:Date = Date()
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        return dateFormatter.string(from: date)
//    }
//}

import Foundation

struct QrData: Codable {
    // primary keys
    var id: Int
    var value: String
//    var date: String

    // 선택 입력값은 optional 사용
    var type: String?

    func getCurretDateForString() -> String {
        let date:Date = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return dateFormatter.string(from: date)
    }
}
