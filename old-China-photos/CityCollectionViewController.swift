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
            
            let navigationController = segue.destinationViewController as! UINavigationController
            let recordCollectionViewController = navigationController.viewControllers[0] as! RecordCollectionViewController
            recordCollectionViewController.managedObjectContext = managedObjectContext
        }
    }
}
