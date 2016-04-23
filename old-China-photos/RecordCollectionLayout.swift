//
//  RecordCollectionLayout.swift
//  old-China-photos
//
//  Created by Christian on 4/23/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit

protocol RecordLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat //height for item at index path
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}

class RecordLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var photoHeight: CGFloat = 0
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! RecordLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let attributes = object as? RecordLayoutAttributes {
            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}

class RecordLayout: UICollectionViewLayout {
    
    var delegate: RecordLayoutDelegate!
    var numberOfColumns = 1
    
    private var cache = [RecordLayoutAttributes]() //what we are going to calcualte and pass back to the collection view
    //cache them to create once. Whenever the collection view asks for them we can return
    
    private var contentHeight: CGFloat = 0
    var cellPadding: CGFloat = 0
    
    private var width: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override class func layoutAttributesClass() -> AnyClass {
        return RecordLayoutAttributes.self
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepareLayout() {
        //called whenever a layout operation is going to take place
        
        if cache.isEmpty { //only perform calculations IF cache is empty
            
            let columnWidth = width / CGFloat(numberOfColumns) //width of collection view divided by number of columns
            
            var xOffsets = [CGFloat]()
            
            
            //these are static
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            //y is not static these are going to be added as we loop through all the items
            
            
            var yOffsets = [CGFloat](count: numberOfColumns, repeatedValue: 0)
            
            var column = 0 //current column... increment as we move through the columns
            
            for item in 0..<collectionView!.numberOfItemsInSection(0) { //only have one section in this layout, so use section zero
                let indexPath = NSIndexPath(forItem: item, inSection: 0) //index path for that item
                
                let width = columnWidth - (cellPadding * 2)
                let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
                
                let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
                
                let height = cellPadding + photoHeight + annotationHeight + cellPadding //actual height
                
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
                
                let attributes = RecordLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = insetFrame
                attributes.photoHeight = photoHeight
                
                cache.append(attributes)
                
                contentHeight = max(contentHeight, CGRectGetMaxY(frame)) //gives us the tallest column
                yOffsets[column] = yOffsets[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : ++column
                
            }
            
            
        }
    }
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
            
        }
        
        return layoutAttributes
    }
}
