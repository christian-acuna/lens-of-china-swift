//
//  City.swift
//  old-China-photos
//
//  Created by Christian on 4/26/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import Foundation
import CoreData
import MapKit


class City: NSManagedObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return "This is a test"
    }
    
    

// Insert code here to add functionality to your managed object subclass

}
