//
//  RegisteredPushTableViewCell.swift
//  ReserveNotification
//
//  Created by Conner on 2023/03/21.
//

import UIKit

class RegisteredPushTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    public func setCellText(text: String?) {
        self.label.text = text
    }
}
