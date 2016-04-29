//
//  City+CoreDataProperties.swift
//  old-China-photos
//
//  Created by Christian on 4/26/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension City {

    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var name: String
    @NSManaged var imageURI: String
    @NSManaged var cityDescription: String

}
