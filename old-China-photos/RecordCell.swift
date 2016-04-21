//
//  RecordCell.swift
//  old-China-photos
//
//  Created by Christian on 4/21/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {
    
    @IBOutlet weak var primaryTitleLabel: UILabel!
    @IBOutlet weak var makerNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureForRecrod(record: Record) {
        primaryTitleLabel.text = record.primaryTitle
        makerNameLabel.text = record.makerName
    }

}
