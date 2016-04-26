//
//  AppDelegate.swift
//  old-China-photos
//
//  Created by Christian on 4/21/16.
//  Copyright © 2016 Crossroads. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let tabBarController = window!.rootViewController as! UITabBarController
        if let tabBarControllers = tabBarController.viewControllers {
//            let navigationController = tabBarControllers[1] as!
//            let photoFeedViewController = navigationController.viewControllers[0] as! PhotoFeedTableViewController
//            photoFeedViewController.managedObjectContext = managedObjectContext
            
            let navigationController = tabBarControllers[0] as! UINavigationController
            let cityCollectionViewController = navigationController.viewControllers[0] as! CityCollectionViewController
            cityCollectionViewController.managedObjectContext = managedObjectContext
            
//            let navigationController2 = tabBarControllers[1] as! UINavigationController
//            let recordCollectionViewController = navigationController2.viewControllers[0] as! RecordCollectionViewController
//            recordCollectionViewController.managedObjectContext = managedObjectContext
        }
        
        preloadData()

        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: Core Data
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        //1
        guard let modelURL = NSBundle.mainBundle().URLForResource(
        "DataModel", withExtension: "momd") else { fatalError("Could not find data model in app bundle")
        }
        //2
        guard let model = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing model from: \(modelURL)")
        }
        //3
        let urls = NSFileManager.defaultManager().URLsForDirectory( .DocumentDirectory, inDomains: .UserDomainMask)
        let documentsDirectory = urls[0]
        let storeURL = documentsDirectory.URLByAppendingPathComponent(
            "DataStore.sqlite")
        do {
            //4
            let coordinator = NSPersistentStoreCoordinator(
                managedObjectModel: model)
            //5
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            //6
            let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            context.persistentStoreCoordinator = coordinator
            print(storeURL)
            return context
            //7
        } catch {
            fatalError("Error adding persistent store at \(storeURL): \(error)") }
    }()
    
    
    
    // MARK: - CSV Parser Methods
    
    func parseCSVRecord (contentsOfURL: NSURL, encoding: NSStringEncoding) -> [(recordID:String, primaryTitle:String, makerName: String, type: String,
        medium: String, place: String, date: String, source: String, creditLine: String, objectNumber: String, department: String, dimensions: String,
        culture: String, imageThumbURI: String, recordLink: String, latitude: String, longitude: String)]? {
        
        // Load the CSV file and parse it
        //recordID,PrimaryTitle,MakerName,Type,Medium,Place,Date,Source,CreditLine,ObjectNumber,Department,Dimensions,Culture,imageThumbURI,recordLink
        let delimiter = ","
        var items:[(recordID:String, primaryTitle:String, makerName: String, type: String,
        medium: String, place: String, date: String, source: String, creditLine: String, objectNumber: String, department: String, dimensions: String,
            culture: String, imageThumbURI: String, recordLink: String, latitude: String, longitude: String)]?
        
        do {
            let content = try String(contentsOfURL: contentsOfURL, encoding: encoding)
            print(content)
            items = []
            let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
            
            for line in lines {
                var values:[String] = []
                if line != "" {
                    // For a line with double quotes
                    // we use NSScanner to perform the parsing
                    if line.rangeOfString("\"") != nil {
                        var textToScan:String = line
                        var value:NSString?
                        var textScanner:NSScanner = NSScanner(string: textToScan)
                        while textScanner.string != "" {
                            
                            if (textScanner.string as NSString).substringToIndex(1) == "\"" {
                                textScanner.scanLocation += 1
                                textScanner.scanUpToString("\"", intoString: &value)
                                textScanner.scanLocation += 1
                            } else {
                                textScanner.scanUpToString(delimiter, intoString: &value)
                            }
                            
                            // Store the value into the values array
                            values.append(value as! String)
                            
                            // Retrieve the unscanned remainder of the string
                            if textScanner.scanLocation < textScanner.string.characters.count {
                                textToScan = (textScanner.string as NSString).substringFromIndex(textScanner.scanLocation + 1)
                            } else {
                                textToScan = ""
                            }
                            textScanner = NSScanner(string: textToScan)
                        }
                        
                        // For a line without double quotes, we can simply separate the string
                        // by using the delimiter (e.g. comma)
                    } else  {
                        values = line.componentsSeparatedByString(delimiter)
                    }
                    
                    // Put the values into the tuple and add it to the items array
//                    let item = (name: values[0], detail: values[1], price: values[2])
                    let item = (recordID: values[0], primaryTitle: values[1], makerName: values[2], type: values[3],
                        medium: values[4], place: values[5], date: values[6], source: values[7], creditLine: values[8], objectNumber: values[9], department: values[10], dimensions: values[11],
                        culture: values[12], imageThumbURI: values[13], recordLink: values[14], latitude: values[15], longitude: values[16])
                    items?.append(item)
                }
            }
            
        } catch {
            print(error)
        }
        
        return items
    }
    
//    @NSManaged var latitude: Double
//    @NSManaged var longitude: Double
//    @NSManaged var name: String
//    @NSManaged var imageURI: String

    func parseCSVCity (contentsOfURL: NSURL, encoding: NSStringEncoding) -> [(name:String, imageURI:String, latitude: String, longitude: String)]? {
            
            // Load the CSV file and parse it
            //recordID,PrimaryTitle,MakerName,Type,Medium,Place,Date,Source,CreditLine,ObjectNumber,Department,Dimensions,Culture,imageThumbURI,recordLink
            let delimiter = ","
            var items:[(name:String, imageURI:String, latitude: String, longitude: String)]?
            
            do {
                let content = try String(contentsOfURL: contentsOfURL, encoding: encoding)
                print(content)
                items = []
                let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
                
                for line in lines {
                    var values:[String] = []
                    if line != "" {
                        // For a line with double quotes
                        // we use NSScanner to perform the parsing
                        if line.rangeOfString("\"") != nil {
                            var textToScan:String = line
                            var value:NSString?
                            var textScanner:NSScanner = NSScanner(string: textToScan)
                            while textScanner.string != "" {
                                
                                if (textScanner.string as NSString).substringToIndex(1) == "\"" {
                                    textScanner.scanLocation += 1
                                    textScanner.scanUpToString("\"", intoString: &value)
                                    textScanner.scanLocation += 1
                                } else {
                                    textScanner.scanUpToString(delimiter, intoString: &value)
                                }
                                
                                // Store the value into the values array
                                values.append(value as! String)
                                
                                // Retrieve the unscanned remainder of the string
                                if textScanner.scanLocation < textScanner.string.characters.count {
                                    textToScan = (textScanner.string as NSString).substringFromIndex(textScanner.scanLocation + 1)
                                } else {
                                    textToScan = ""
                                }
                                textScanner = NSScanner(string: textToScan)
                            }
                            
                            // For a line without double quotes, we can simply separate the string
                            // by using the delimiter (e.g. comma)
                        } else  {
                            values = line.componentsSeparatedByString(delimiter)
                        }
                        
                        // Put the values into the tuple and add it to the items array
//                       (name:String, imageURI:String, latitude: String, longitude: String)
                        let item = (name: values[0], imageURI: values[1], latitude: values[2], longitude: values[3])
                        items?.append(item)
                    }
                }
                
            } catch {
                print(error)
            }
            
            return items
    }

    func preloadData() {
        guard let contentsOfURL = NSBundle.mainBundle().URLForResource("record", withExtension: "csv") else {
            return
        }
        
        removeData()
        if let items = parseCSVRecord(contentsOfURL, encoding: NSUTF8StringEncoding) {
            //Preload the menu items
            for item in items {
                let recordItem = NSEntityDescription.insertNewObjectForEntityForName("Record", inManagedObjectContext: managedObjectContext) as! Record
                recordItem.recordID = item.recordID
                recordItem.primaryTitle = item.primaryTitle
                recordItem.makerName = item.makerName
                recordItem.type = item.type
                recordItem.medium = item.medium
                recordItem.place = item.place
                recordItem.date = item.date
                recordItem.source = item.source
                recordItem.creditLine = item.creditLine
                recordItem.objectNumber = item.objectNumber
                recordItem.department = item.department
                recordItem.dimensions = item.dimensions
                recordItem.culture = item.culture
                recordItem.imageThumbURI = item.imageThumbURI
                recordItem.recordLink = item.recordLink
                recordItem.latitude = (item.latitude as NSString).doubleValue
                recordItem.longitude = (item.longitude as NSString).doubleValue
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
            
        }
        
        guard let contentsOfURLForCity = NSBundle.mainBundle().URLForResource("cities", withExtension: "csv") else {
            return
        }
        
        if let cityItems = parseCSVCity(contentsOfURLForCity, encoding: NSUTF8StringEncoding) {
            //Preload the menu items
            for cityItem in cityItems {
                let managedCityItem = NSEntityDescription.insertNewObjectForEntityForName("City", inManagedObjectContext: managedObjectContext) as! City

                managedCityItem.latitude = (cityItem.latitude as NSString).doubleValue
                managedCityItem.longitude = (cityItem.longitude as NSString).doubleValue
                managedCityItem.imageURI = cityItem.imageURI
                managedCityItem.name = cityItem.name
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
            
        }

    }
    
    func removeData() {
        let recordFetchRequest = NSFetchRequest(entityName: "Record")
        
        do {
            let recordItems = try managedObjectContext.executeFetchRequest(recordFetchRequest) as! [Record]
            for recordItem in recordItems {
                managedObjectContext.deleteObject(recordItem)
            }
        } catch {
            print(error)
        }
        
        let cityFetchRequest = NSFetchRequest(entityName: "City")
        
        do {
            let cityItems = try managedObjectContext.executeFetchRequest(cityFetchRequest) as! [City]
            for cityItem in cityItems {
                managedObjectContext.deleteObject(cityItem)
            }
        } catch {
            print(error)
        }
        
    }
}


