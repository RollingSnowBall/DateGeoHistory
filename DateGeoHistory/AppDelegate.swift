//
//  AppDelegate.swift
//  DateGeoHistory
//
//  Created by JUNO on 2022/08/10.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration (
                             
        // 중요! 스키마버전 셋팅
        // 이전 버전보다 반드시 커야함
        schemaVersion: 1,

        migrationBlock: { migration, oldSchemaVersion in
             
            // 셋팅한 스키마 버전보다 낮을경우 해당 코드 호출
            if (oldSchemaVersion < 1) {
                 
                // 신규 업데이트 내용 추가
                migration.enumerateObjects(ofType: Schedule.className()) { // 추가할 컬럼 클래스
                    oldObject, newObject in
                    newObject!["title"] = String() // 추가한 컬럼값 = 자료형()
                }
            }
        })
                 
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

