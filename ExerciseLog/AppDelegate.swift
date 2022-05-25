//
//  AppDelegate.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/08.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    let version:UInt64 = 7
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let config = Realm.Configuration(
                  // スキーマバージョン設定
                  schemaVersion: version,
                  //実際のマイグレーション処理　古いスキーマバージョンのRealmを開こうとすると自動的にマイグレーションが実行
                  migrationBlock: { migration, oldSchemaVersion in
                    // 初めてのマイグレーションの場合、oldSchemaVersionは0
                      if (oldSchemaVersion < self.version) {
                      // 変更点を自動的に認識しスキーマをアップデートする
                    }
                  })

        Realm.Configuration.defaultConfiguration = config
        do {
            let realm = try Realm()
            print(realm)
            
        } catch {
            print("Error initializing new Realm,\(error)")
        }
        
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

