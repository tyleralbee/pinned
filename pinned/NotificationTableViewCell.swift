//
//  NotificationTableViewCell.swift
//  pinned
//
//  Created by Tyler Albee on 7/20/19.
//  Copyright © 2019 Tyler Albee. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
