//
//  RecordViewController.swift
//  old-China-photos
//
//  Created by Christian on 4/25/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var primaryTitleLabel: UILabel!
    
    
    var record: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let record = record {
            primaryTitleLabel.text = record.primaryTitle
            detailButton.setImage(UIImage(named: record.imageThumbURI), forState: .Normal)
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
