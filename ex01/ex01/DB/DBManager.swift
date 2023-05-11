//
//  DBManager.swift
//  ex01
//
//  Created by jjglobal on 2023/05/03.
//

import RealmSwift

protocol DataBase {
    func read<T: Object>(object: T) -> Results<T>
    func fetch<T: Object>(object: T, date: String) -> Results<T>
    func write<T: Object>(object: T, _ errorHandler: @escaping ((_ error : Swift.Error) -> Void))
    func update<T: Object>(object: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void))
    func delete<T: Object>(object: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void))
    func asyncWrite<T: ThreadConfined>(object: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void), action: @escaping ((Realm, T?) -> Void))
}

public class DBManager : DataBase{
    
    private let database: Realm
    
    /// The shared instance of the realm manager.
    static let sharedInstance = DBManager()
    
    /// Private initializer for the realm manager. Crashes if it cannot open the database.
    private init() {
        
        do {
            database = try Realm()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /// Retrieves the given object type from the database.
    ///
    /// - Parameter object: The type of object to retrieve.
    /// - Returns: The results in the database for the given object type.
    public func read<T: Object>(object: T) -> Results<T> {
//        return database.objects(T.self)
        return database.objects(T.self).filter("date >= %@", 2023-05-08)
    }

    public func fetch<T: Object>(object: T, date: String) -> Results<T> {
        return database.objects(T.self).filter("date LIKE %@", "*\(date)*")
    }
    
    /// Writes the given object to the database.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
    public func write<T: Object>(object: T, _ errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
                database.add(object)
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    /// Overwrites the given object in the database if it exists. If not, it will write it as a new object.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
    public func update<T: Object>(object: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
                database.add(object, update: .modified)
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    /// Deletes the given object from the database if it exists.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
    public func delete<T: Object>(object: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
                database.delete(object)
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    /// Deletes all existing data from the database. This includes all objects of all types.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
    public func deleteAll(errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }) {
        do {
            try database.write {
                database.deleteAll()
            }
        }
        catch {
            errorHandler(error)
        }
    }
    
    /// Write method (supports save, update + delete) to be used in asynchronous situations. Write logic is passed in via the "action" closure parameter.
    /// Custom error handling available as a closure parameter (default just returns).
    ///
    /// - Returns: Nothing
    public func asyncWrite<T: ThreadConfined>(object: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }, action: @escaping ((Realm, T?) -> Void)) {
        let threadSafeRef = ThreadSafeReference(to: object)
        let config = self.database.configuration
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: config)
                    let obj = realm.resolve(threadSafeRef)
                    
                    try realm.write {
                        action(realm, obj)
                    }
                }
                catch {
                    errorHandler(error)
                }
            }
        }
    }
    
}
