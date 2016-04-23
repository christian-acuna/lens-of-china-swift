//
//  DetailRecordViewController.swift
//  old-China-photos
//
//  Created by Christian on 4/23/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit

class DetailRecordViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var primaryTitleLabel: UILabel!
    
    var record: Record?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let record = record {
            primaryTitleLabel.text = record.primaryTitle
            detailImageView.image = UIImage(named: record.imageThumbURI)
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
