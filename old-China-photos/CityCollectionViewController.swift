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

    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CityCell", forIndexPath: indexPath) as! CityCell
        
        let city = cities[indexPath.item]
        
        cell.configureCollectionForCity(city)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cityToRecord" {
            
            let navigationController = segue.destinationViewController as! UINavigationController
            let recordCollectionViewController = navigationController.viewControllers[0] as! RecordCollectionViewController
            recordCollectionViewController.managedObjectContext = managedObjectContext
        }
    }
}
