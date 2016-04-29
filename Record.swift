//
//  Record.swift
//  old-China-photos
//
//  Created by Christian on 4/21/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import Foundation
import CoreData
import MapKit


class Record: NSManagedObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    var title: String? {
        return primaryTitle
    }
    
    var subtitle: String? {
        return makerName
    }
        
}
