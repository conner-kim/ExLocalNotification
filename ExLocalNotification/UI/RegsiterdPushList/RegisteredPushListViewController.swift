//
//  RegisteredPushListViewController.swift
//  ReserveNotification
//
//  Created by Conner on 2023/03/21.
//

import UIKit

final class RegisteredPushListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    var pendingNotificationList = [String]()
    
    
    // MARK: - Setting View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingSubviews()
    }
    
    private func settingSubviews() {
        self.navigationItem.title = "푸시 예약 로그"
        
        self.tableView.register(.init(nibName: "RegisteredPushTableViewCell", bundle: nil), forCellReuseIdentifier: RegisteredPushTableViewCell.description())

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    // MARK: - LifeCycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.pendingNotificationList = []
        userNotificationCenter.getPendingNotificationRequests { notificationRequestList in
            print("getPendingNotificationRequests: \(notificationRequestList)")
            notificationRequestList.forEach { request in
                self.pendingNotificationList.append(request.content.body)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


extension RegisteredPushListViewController: UITableViewDelegate {
    
}



extension RegisteredPushListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pendingNotificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        var cell = UITableViewCell()
        
        guard let reusableCell = tableView.dequeueReusableCell(withIdentifier: RegisteredPushTableViewCell.description()) as? RegisteredPushTableViewCell else {
            return cell
        }
        
        guard self.pendingNotificationList.count > row else {
            return cell
        }
        
        reusableCell.setCellText(text: self.pendingNotificationList[row])
        
        cell = reusableCell
        return cell
    }
}
