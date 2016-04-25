//
//  MapViewController.swift
//  old-China-photos
//
//  Created by Christian on 4/25/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        mapView.delegate = self
    }
    @IBAction func showLocations(sender: AnyObject) {
    }
    
    
}



extension MapViewController: MKMapViewDelegate {
    
    
}
