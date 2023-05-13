//
//  AppDelegate.swift
//  ExLocalNotification
//
//  Created by Conner on 2023/05/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 알림 센터 가져오기
        let center = UNUserNotificationCenter.current()
        
        
        // 권한 종류 만들기 (뱃지와 소리)
        let options = UNAuthorizationOptions(arrayLiteral: [.badge, .sound, .alert])
        
        // 권한 요청 메서드(꼭 이곳이 아니어도 원할때 권한을 받을 수 있다.)
        center.requestAuthorization(options: options) { success, error in
            // 권한에 따라 success가 허용->true, 거부->error
            
            if let error = error {
                print("에러 발생: \(error.localizedDescription)")
            }
            
            // 권한을 받은 후에 delegate을 설정해줘야함
            center.delegate = self
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


// User 알림에 대한 delegate 설정
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 푸쉬가 오면 다음을 표시하라는 뜻
        // 배너는 배너, 뱃지는 앱 아이콘에 숫자 뜨는것, 사운드는 알림 소리, list는 알림센터에 뜨는거
        print("willPresent Push")
        center.setBadgeCount(1)
        completionHandler([.banner, .badge, .sound, .list])
    }
    
    // 푸시 클릭시 동작
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("notification receive: \n\n\(response.notification.request.content.userInfo))\n\n")
        center.setBadgeCount(0)
        
        let userInfo = response.notification.request.content.userInfo
        
        if let takeMedicineId = userInfo["TAKE_MEDICINE_ID"] as? Int {
            switch response.actionIdentifier {
            case NotificationActionType.taking.rawValue:
                print("복용함")
                
                BloodTypeAPI.shared.load()
                break
            case NotificationActionType.notTaking.rawValue:
                print("미복용")
                break
            default:
                break
            }
        }
        completionHandler()
    }
}
