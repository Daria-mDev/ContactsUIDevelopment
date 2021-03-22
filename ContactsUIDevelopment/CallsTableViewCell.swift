//
//  CallsTableViewCell.swift
//  ContactsUIDevelopment
//
//  Created by user on 22.03.2021.
//

import UIKit

class CallsTableViewCell: UITableViewCell {
    
    @IBOutlet var contactLabel: UILabel!
    @IBOutlet var callTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
