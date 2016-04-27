//
//  RecordViewController.swift
//  old-China-photos
//
//  Created by Christian on 4/25/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    
    @IBOutlet weak var recordImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var record: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        if let record = record {
            recordImageView.image = UIImage(named: record.imageThumbURI)
            title = record.primaryTitle
        }
        
        tableView.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "recordToZoom" {
            let detailRecordViewController = segue.destinationViewController as! DetailRecordViewController
            detailRecordViewController.imageRecord = record
        }
    }

}

extension RecordViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecordCell", forIndexPath: indexPath) as! RecordDetailTableViewCell
        if let record = record {
            switch indexPath.row {
            case 0:
                cell.fieldLabel.text = "Name"
                cell.valueLabel.text = record.primaryTitle
            case 1:
                cell.fieldLabel.text = "Artist"
                cell.valueLabel.text = record.makerName
            case 2:
                cell.fieldLabel.text = "Date"
                cell.valueLabel.text = record.date
            case 3:
                cell.fieldLabel.text = "Type"
                cell.valueLabel.text = record.type
            case 4:
                cell.fieldLabel.text = "Medium"
                cell.valueLabel.text = record.medium
            case 5:
                cell.fieldLabel.text = "Place"
                cell.valueLabel.text = record.place
            case 6:
                cell.fieldLabel.text = "Source"
                cell.valueLabel.text = record.source
            case 7:
                cell.fieldLabel.text = "Credit"
                cell.valueLabel.text = record.creditLine
            case 8:
                cell.fieldLabel.text = "Object Number"
                cell.valueLabel.text = record.objectNumber
            case 9:
                cell.fieldLabel.text = "Dimensions"
                cell.valueLabel.text = record.dimensions
            case 10:
                cell.fieldLabel.text = "Culture"
                cell.valueLabel.text = record.culture
            case 11:
                cell.fieldLabel.text = "Record"
                cell.valueLabel.text = record.recordLink
                
            default:
                cell.fieldLabel.text = ""
                cell.valueLabel.text = ""
            }
        }
        
        cell.backgroundColor = UIColor.clearColor()
        return cell
        
    }
}

extension RecordViewController: UITableViewDelegate {
    
}
