//
//  FirstViewController.swift
//  old-China-photos
//
//  Created by Christian on 4/21/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit
import CoreData

class PhotoFeedTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var records = [Record]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("Record", inManagedObjectContext: managedObjectContext)
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key: "primaryTitle", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let foundObjects = try managedObjectContext.executeFetchRequest(fetchRequest)
            records = foundObjects as! [Record]
        } catch {
            print(error)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecordCell", forIndexPath: indexPath)
        let record = records[indexPath.row]
        
        let primaryTitleLabel = cell.viewWithTag(100) as! UILabel
        primaryTitleLabel.text = record.primaryTitle
        
        let makerLabel = cell.viewWithTag(101) as! UILabel
        makerLabel.text = record.makerName
        
        return cell
    }

}

