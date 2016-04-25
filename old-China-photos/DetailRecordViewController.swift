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
    @IBOutlet weak var scrollView: UIScrollView!
    
//    recordToZoom
    var imageRecord: Record?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let record = imageRecord {
            primaryTitleLabel.text = record.primaryTitle
            detailImageView.image = UIImage(named: record.imageThumbURI)
        }
        updateMinZoomScaleForSize(view.bounds.size)
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    @IBAction func closeView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func updateMinZoomScaleForSize(size: CGSize) {
        let widthScale = size.width / detailImageView.bounds.width
        let heightScale = size.height / detailImageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
}

extension DetailRecordViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return detailImageView
    }
}
