//
//  CityCell.swift
//  old-China-photos
//
//  Created by Christian on 4/24/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit

class CityCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageCoverView: UIView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var timeAndRoomLabel: UILabel!
    @IBOutlet private weak var speakerLabel: UILabel!
    
    
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        let featuredHeight = CityLayoutConstants.Cell.featuredHeight
        let standardHeight = CityLayoutConstants.Cell.standardHeight
        
        let delta = 1 - ((featuredHeight - CGRectGetHeight(frame)) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        let scale = max(delta, 0.5)
//        cityLabel.transform = CGAffineTransformMakeScale(scale, scale)
//        timeAndRoomLabel.alpha = delta
//        speakerLabel.alpha = delta
    }
    
    func configureCollectionForCity(city: String) {
        imageView.image = UIImage(named: city)
    }
    
    
    
}
