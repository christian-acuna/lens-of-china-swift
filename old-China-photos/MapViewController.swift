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
    
    var cities = [City]()
    
    var managedObjectContext: NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        mapView.delegate = self
        let entity = NSEntityDescription.entityForName("City", inManagedObjectContext: managedObjectContext)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entity
        
        cities = try! managedObjectContext.executeFetchRequest(fetchRequest) as! [City]
        mapView.addAnnotations(cities)
    }
    
    @IBAction func showLocations(sender: AnyObject) {
    }
    
    
}



extension MapViewController: MKMapViewDelegate {
    
    
}
