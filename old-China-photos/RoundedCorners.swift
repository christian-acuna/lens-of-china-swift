//
//  RoundedCorners.swift
//  old-China-photos
//
//  Created by Christian on 4/23/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}

