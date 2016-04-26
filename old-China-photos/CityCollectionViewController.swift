//
//  CityCollectionViewController.swift
//  old-China-photos
//
//  Created by Christian on 4/24/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class CityCollectionViewController: UICollectionViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    
    var cities = [City]()

//    var cities = ["30753001", "18857901", "30757701", "30345401", "30751901"]
//    let names = ["Beijing", "Shanghai", "Canton", "Macao", "Tianjin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("City", inManagedObjectContext: managedObjectContext)
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let foundObjects = try managedObjectContext.executeFetchRequest(fetchRequest)
            cities = foundObjects as! [City]
        } catch {
            print(error)
        }
        
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView!.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
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
        return cities.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CityCell", forIndexPath: indexPath) as! CityCell
        
        let city = cities[indexPath.item]
        
        cell.configureCollectionForCity(city)
        // Configure the cell
    
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cityToRecord" {
            let recordCollectionViewController = segue.destinationViewController as! RecordCollectionViewController
            recordCollectionViewController.managedObjectContext = managedObjectContext
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
