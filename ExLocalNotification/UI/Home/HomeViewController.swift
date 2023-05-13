//
//  HomeViewController.swift
//  ExLocalNotification
//
//  Created by Conner on 2023/05/14.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var bloodTypeLabel: UILabel!
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.removePendingNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let bloodType = UserDefaults.standard.string(forKey: "bloodType") {
            self.bloodTypeLabel.text = "혈액형: \(bloodType)"
        }
    }
    
    
    // MARK: - User Interaction
    // 즉시 전송 클릭
    @IBAction func didTapSendImmediatelyButton(_ sender: Any) {
        userNotificationCenter.sendPusnCustomAction(title: "푸시 즉시 전송", body: "푸시테스트중입니다 하하하하하하")
    }
    
    // 5초 후 전송 클릭
    @IBAction func didTapSendAfter5SecButton(_ sender: Any) {
        let date = Date()
        let nextDate = date.adding(.second, 5)
        userNotificationCenter.sendPushReservation(
            title: "\(date.formattedString()) 푸시 송신",
            body: "\(nextDate.formattedString()) 푸시 수신",
            date: nextDate
        )
    }
    
    // 10초 후 전송 클릭
    @IBAction func didTapSendAfter10SecButton(_ sender: Any) {
        let date = Date()
        let nextDate = date.adding(.second, 10)
        userNotificationCenter.sendPushReservation(
            title: "\(date.formattedString()) 푸시 송신",
            body: "\(nextDate.formattedString()) 푸시 수신",
            date: nextDate
        )
    }
    
    // 10분주기 5번 전송
    @IBAction func didTapReservePushButton(_ sender: Any) {
        (1...5).forEach {
            let date = Date()
            let minute = $0 * 10
            let title = "10분 텀 푸시 예약"
            let body = "\(date.formattedString()) 예약 - \(minute)분 후"
            userNotificationCenter.sendPushReservation(
                title: title,
                body: body,
                date: date.adding(.minute, minute)
            )
        }
    }
    
    // 등록된 푸시 보기 클릭
    @IBAction func didTapShowRegisteredNotification(_ sender: Any) {
        self.navigationController?.pushViewController(RegisteredPushListViewController(), animated: true)
    }
}


extension HomeViewController {
    private func removePendingNotification() {
        // 기존 예약 푸시 모두 삭제
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: ["FRIDAY_PUSH"])
    }
}
