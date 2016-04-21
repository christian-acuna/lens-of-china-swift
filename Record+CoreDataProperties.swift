//
//  Record+CoreDataProperties.swift
//  old-China-photos
//
//  Created by Christian on 4/21/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Record {

    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var primaryTitle: String
    @NSManaged var makerName: String
    @NSManaged var type: String
    @NSManaged var medium: String
    @NSManaged var place: String
    @NSManaged var date: String
    @NSManaged var source: String
    @NSManaged var creditLine: String
    @NSManaged var objectNumber: String
    @NSManaged var department: String
    @NSManaged var dimensions: String
    @NSManaged var culture: String
    @NSManaged var imageThumbURI: String
    @NSManaged var recordLink: String

}
