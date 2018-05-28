//
//  TableViewCell.swift
//  PinUp
//
//  Created by Xavier Davis on 5/25/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskCreator: UILabel!
    @IBOutlet weak var payoutAmount: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var taskDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
