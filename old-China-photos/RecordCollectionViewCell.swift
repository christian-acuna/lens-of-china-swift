//
//  RecordCollectionViewCell.swift
//  old-China-photos
//
//  Created by Christian on 4/22/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit

class RecordCollectionViewCell: UICollectionViewCell {
    @IBOutlet var recordImageView: UIImageView!
    @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var primaryTitleLabel: UILabel!
    
    
    func configureCollectionForRecrod(record: Record) {
        
        let image = UIImage(named: record.imageThumbURI)
        recordImageView.image = image
        captionLabel.text = record.makerName
        dateLabel.text = record.date
        primaryTitleLabel.text = record.primaryTitle
        
        
        //        if let url = NSURL(string: record.imageThumbURI) {
        //            downloadTask = imageThumb.loadImageWithURL(url)
        //        }
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let attributes = layoutAttributes as! RecordLayoutAttributes
        imageViewHeightLayoutConstraint.constant = attributes.photoHeight
    }
    
}
