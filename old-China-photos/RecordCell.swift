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
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var imageThumb: UIImageView!
    
    var downloadTask : NSURLSessionDownloadTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
        
        primaryTitleLabel.text = nil
        makerNameLabel.text = nil
        typeLabel.text = nil
        mediumLabel.text = nil
        placeLabel.text = nil
        imageThumb.image = nil
        
        
    }

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
        typeLabel.text = record.type
        mediumLabel.text = record.medium
        placeLabel.text = record.place
        if let url = NSURL(string: record.imageThumbURI) {
            downloadTask = imageThumb.loadImageWithURL(url)
        }
    }

}
