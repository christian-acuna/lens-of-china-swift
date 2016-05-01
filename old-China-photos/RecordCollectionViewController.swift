//
//  RecordCollectionViewController.swift
//  old-China-photos
//
//  Created by Christian on 4/22/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class RecordCollectionViewController: UICollectionViewController {
    
    var records = [Record]()
    var managedObjectContext: NSManagedObjectContext!
    
    var cityCollectionToView: Int?
    let entityName = "Record"
    let idAttribute: String = "place"
    var placePredicateFilter = "Pekin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let city = cityCollectionToView {
            switch city {
            case 0:
                placePredicateFilter = "Pekin"
                title = "Pekin (Beijing)"
            case 1:
                placePredicateFilter = "Canton"
                title = "Canton (Guangzhou)"
            case 2:
                placePredicateFilter = "Macao"
                title = "Macao (Aomen)"
            case 3:
                placePredicateFilter = "Shanghai"
                title = "Shanghai"
            case 4:
                placePredicateFilter = "Tianjin"
                title = "Tianjin"
            default:
                placePredicateFilter = "Tianjin"
                title = "Tianjin"
            }
        }
        
        let placePredicate = NSPredicate(format: "%K CONTAINS[cd] %@", idAttribute, placePredicateFilter)
        
        let sortDescriptor = NSSortDescriptor(key: "primaryTitle", ascending: true)
        if let results = getData([sortDescriptor], predicate: placePredicate) {
            records = results
        }
        
        let size = CGRectGetWidth(collectionView!.bounds) / 2
        collectionView!.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        
        let layout = collectionViewLayout as! RecordLayout
        layout.delegate = self
        layout.numberOfColumns = 2
        layout.cellPadding = 5
    }
    
    func getData(sort:[NSSortDescriptor], predicate: NSPredicate) -> [Record]? {
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedObjectContext)
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sort
        
        if let results = try? managedObjectContext.executeFetchRequest(fetchRequest) as! [Record] {
            return results
        } else {
            return nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return records.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! RecordCollectionViewCell
        let record = records[indexPath.item]
    
        cell.configureCollectionForRecrod(record)
    
        return cell
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let record = records[indexPath.item]
            performSegueWithIdentifier("MasterToDetail", sender: record)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MasterToDetail" {
            let detailRecordViewController = segue.destinationViewController as! RecordViewController
            detailRecordViewController.record = sender as? Record
        }
    }
}

extension RecordCollectionViewController: RecordLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        let photoRecord = records[indexPath.item]
        
        if let photo = UIImage(named: photoRecord.imageThumbURI) {
            let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
            let rect = AVMakeRectWithAspectRatioInsideRect(photo.size, boundingRect)
            return rect.height
        } else {
            let photo = UIImage(named: "placeholder")!
            let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
            let rect = AVMakeRectWithAspectRatioInsideRect(photo.size, boundingRect)
            return rect.height
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        return 60
    }
}
