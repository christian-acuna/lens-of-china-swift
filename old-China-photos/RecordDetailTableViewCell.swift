//
//  RecordDetailTableViewCell.swift
//  old-China-photos
//
//  Created by Christian on 4/26/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit

class RecordDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
