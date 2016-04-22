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
    
    
    func configureCollectionForRecrod(record: Record) {
        
        let url = NSURL(string: record.imageThumbURI)
        if let imageName = url?.pathComponents?.last, image = UIImage(named: imageName) {
            recordImageView.image = image
        }
        
        //        if let url = NSURL(string: record.imageThumbURI) {
        //            downloadTask = imageThumb.loadImageWithURL(url)
        //        }
    }
    
}
