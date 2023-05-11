//
//  QrDataTable.swift
//  ex01
//
//  Created by jjglobal on 2023/05/10.
//
struct QrDataTable {
    
    let tableName = "qrData"
    let columnId = "id"
    let columnValue = "value"
    let columnRegDate = "date"
    
    var queryCreateTable: String {
        get {
            return """
                create table if not exists \(self.tableName)(
                \(self.columnId) INTEGER primary key autoincrement,
                \(self.columnValue) text,
                \(self.columnRegDate) text not null);
                """
        }
    }
    var queryDropTable: String {
        get {
            return "DROP TABLE \(self.tableName);"
        }
    }
    var selectAllData: String {
        get {
            return "select * from \(self.tableName);"
        }
    }
    var deleteData: String {
        get {
            return "delete from \(self.tableName);"
        }
    }
    var updateDate: String {
        get {
            return "update \(self.tableName) set id = 2 where id = 5;"
            
        }
    }
    
}
