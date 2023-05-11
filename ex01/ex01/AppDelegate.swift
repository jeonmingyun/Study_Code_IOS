//
//  AppDelegate.swift
//  ex01
//
//  Created by jjglobal on 2023/03/30.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initRealmDBVersion()
        
        return true
    }
    
    func initRealmDBVersion() {
//        do {
//            // Delete the realm if a migration would be required, instead of migrating it.
//            // While it's useful during development, do not leave this set to `true` in a production app!
//            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//            let realm = try Realm(configuration: configuration)
//        
//        } catch {
//            print("Error opening realm: \(error.localizedDescription)")
//        }
        
        
//        let version: UInt64 = 3 // DB 버전
//
//        // 1. config 설정(이전 버전에서 다음 버전으로 마이그레이션될때 어떻게 변경될것인지)
//        let config = Realm.Configuration(
//            schemaVersion: version, // 새로운 스키마 버전 설정
//            migrationBlock: { migration, oldSchemaVersion in
//                if oldSchemaVersion < version {
//                    // 1-1. 마이그레이션 수행(버전 2보다 작은 경우 버전 2에 맞게 데이터베이스 수정)
//                    migration.enumerateObjects(ofType: QrData.className()) { oldObject, newObject in
//                        newObject!["your object name"] = Date()
//                    }
//                }
//            }
//        )
//
//        // 2. Realm이 새로운 Object를 쓸 수 있도록 설정
//        Realm.Configuration.defaultConfiguration = config
    }

}

