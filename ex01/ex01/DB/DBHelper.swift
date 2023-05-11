//
//  DBHelper.swift
//  ex01
//
//  Created by jjglobal on 2023/05/10.
//

import SQLite3
import Foundation

class DBHelper {
    
    static let shared = DBHelper()
    
    private var db : OpaquePointer?
    private var path = "mySQLite.sqlite"
    
    private init(){
        self.db = createDB()
    }
    
    private func createDB() -> OpaquePointer? {
        
        var db : OpaquePointer? = nil
        do {
            
            //appendingPathExtension(path)은 플레이그라운드에서는 되지만 실제 APP에서는 되지 않았다.
            //따라서 이렇게 변경해줘야한다. appendingPathExtension(path) -> appendingPathComponent(path)
            let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
            
            if sqlite3_open(filePath.path, &db) == SQLITE_OK {
                print("Succesfully create Database path : \(filePath.path)")
                createTable(QrDataTable().queryCreateTable)
                return db
            }
            
        }
        catch{
            print("ERROR in CreateDB - \(error.localizedDescription)")
        }
        
        print("ERROR in CreateDB - sqlite3_open ")
        return nil
        
    }
    
    private func createTable(query: String){
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Create Table SuccessFully \(String(describing: db))")
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\n Create Table step fail :  \(errorMessage)")
            }
        }
        else{
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\n create Table sqlite3_prepare Fail ! :\(errorMessage)")
            
        }
        
        sqlite3_finalize(statement)
    }
    
    private func dropTable(query: String){
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Delete Table SuccessFully \(String(describing: db))")
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\n Delete Table step fail ! : \(errorMessage)")
                
            }
        }
        else{
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\n delete Table prepare fail! : \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
    }
    
    func selectData(query: String) -> [QrData] {
        var statement : OpaquePointer? = nil
        var result: [QrData] = []
        print("ddddddddddd")
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW{
                
                let id = sqlite3_column_int(statement, 0)
                //만약에 컬럼이 name 하나 뿐이 였다면 반환되는 결과물도 name 하나 뿐이기 때문에
                //이 부분이 1이 아니라 0이 되어야 한다.
                let value =  String(cString: sqlite3_column_text(statement, 1))
                let date = String(cString: sqlite3_column_text(statement, 2))
                
                result.append(QrData(id: Int(id), value: String(value), date: String(date)))
                do{
                    //sql에 data 타입이 아니라 String 타입으로 저장이 되어 있기 때문에, 반드시 String 타입을 data 타입으로 변경해서 디코드 해줘야한다.
                    let data = try JSONDecoder().decode(QrData.self, from: date.data(using: .utf8)!)
                    print("readData Result : \(id) \(value) \(data)")
                }
                catch{
                    print("JSONDecoder Error : \(error.localizedDescription)")
                }
                
                
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\n read Data prepare fail! : \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
        
        return result
    }
    
    func insertData(name : String, studentInfo: QrData ){
        
        //autocrement일 경우에는 입력 부분에서는 컬럼을 추가 안해줘도 자동으로 추가가 되지만
        //쿼리 문에서는 이렇게 추가 해줘야합니다.
        let query = "insert into myDB (id, name, info) values (?,?,?);"
        
        var statement : OpaquePointer? = nil
        
        do {
            //이렇게 데이터를 인코등 해주고 그 데이터를 String으로 변형 해준다.
            //왜냐하면 bind 해줄 때 data 타입이 없기 때문이다.
            let data = try JSONEncoder().encode(studentInfo)
            let dataToString = String(data: data, encoding: .utf8)
            
            print(dataToString!)
            
            if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
                //insert는 read와 다르게 컬럼의 순서의 시작을 1 부터 한다.
                //따라서 id가 없기 때문에 2로 시작한다.
                sqlite3_bind_text(statement, 2, NSString(string: name).utf8String , -1, nil)
                sqlite3_bind_text(statement, 3, NSString(string: dataToString!).utf8String , -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Insert data SuccessFully : \(String(describing: db))")
                }
                else{
                    let errorMessage = String(cString: sqlite3_errmsg(db))
                    print("\n insert Data sqlite3 step fail! : \(errorMessage)")
                }
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\n insert Data prepare fail! : \(errorMessage)")
            }
            
            
            sqlite3_finalize(statement)
            
        }
        catch{
            print("JSONEncoder Error : \(error.localizedDescription)")
        }
    }
    
    func deleteData(query: String){
            var statement : OpaquePointer? = nil
            
            if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_DONE {
                     print("Delete data SuccessFully : \(String(describing: db))")
                }
                else{
                    let errorMessage = String(cString: sqlite3_errmsg(db))
                    print("\n delete Data prepare fail! : \(errorMessage)")
                }
                
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\n delete Data prepare fail! : \(errorMessage)")
            }
            
            sqlite3_finalize(statement)
        }
    
    func updateData(query: String){
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            
            if sqlite3_step(statement) == SQLITE_DONE {
                 print("Update data SuccessFully : \(String(describing: db))")
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\n delete Data prepare fail! : \(errorMessage)")
            }
            
        }
        else{
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\n delete Data prepare fail! : \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
    }
    
}
