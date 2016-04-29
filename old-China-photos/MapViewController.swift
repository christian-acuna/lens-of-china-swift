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
        mapView.showsCompass = true
        mapView.showsScale = true
        showLocations()
    }

    @IBAction func showLocations() {
        let region = regionForAnnotations(cities)
        mapView.setRegion(region, animated: true)
    }
    
    
    func regionForAnnotations(annotations: [MKAnnotation])
        -> MKCoordinateRegion {
            var region: MKCoordinateRegion
            switch annotations.count { case 0:
                region = MKCoordinateRegionMakeWithDistance( mapView.userLocation.coordinate, 1000, 1000)
            case 1:
                let annotation = annotations[annotations.count - 1]
                region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000)
            default:
                var topLeftCoord = CLLocationCoordinate2D(latitude: -90,
                                                          longitude: 180)
                var bottomRightCoord = CLLocationCoordinate2D(latitude: 90,
                                                                                                                        longitude: -180)
                for annotation in annotations { topLeftCoord.latitude = max(topLeftCoord.latitude,
                                                                            annotation.coordinate.latitude)
                    topLeftCoord.longitude = min(topLeftCoord.longitude, annotation.coordinate.longitude)
                    bottomRightCoord.latitude = min(bottomRightCoord.latitude, annotation.coordinate.latitude)
                    bottomRightCoord.longitude = max(bottomRightCoord.longitude,annotation.coordinate.longitude)
                }
                
                let center = CLLocationCoordinate2D( latitude: topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) / 2, longitude: topLeftCoord.longitude - (topLeftCoord.longitude - bottomRightCoord.longitude) / 2)
                let extraSpace = 1.6
                let span = MKCoordinateSpan(
                    latitudeDelta: abs(topLeftCoord.latitude - bottomRightCoord.latitude) * extraSpace,
                    longitudeDelta: abs(topLeftCoord.longitude - bottomRightCoord.longitude) * extraSpace)
                region = MKCoordinateRegion(center: center, span: span) }
            return mapView.regionThatFits(region)
    }
    
    func showCityDetails(sender: UIButton) {
        performSegueWithIdentifier("showCityCollection", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCityCollection" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! RecordCollectionViewController
            controller.managedObjectContext = managedObjectContext
            
            let button = sender as! UIButton
            controller.cityCollectionToView = button.tag
        }
    }
    
}



extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is City else { return nil }
        
        let identifier = "City"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as! MKPinAnnotationView!
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView.enabled = true
            annotationView.canShowCallout = true
            annotationView.animatesDrop = true
//            annotationView.pinColor = UIColor
            let rightButton = UIButton(type: .DetailDisclosure)
            rightButton.addTarget(self, action: #selector(MapViewController.showCityDetails(_:)), forControlEvents: .TouchUpInside)
            annotationView.rightCalloutAccessoryView = rightButton
        } else {
            annotationView.annotation = annotation
        }
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        let imageName = (annotation as! City)
        leftIconView.image = UIImage(named: imageName.imageURI)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        
        let button = annotationView.rightCalloutAccessoryView as! UIButton
        if let index = cities.indexOf(annotation as! City) {
            button.tag = index
        }
        
        return annotationView
    }
    
}

extension MapViewController: UINavigationBarDelegate {
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
}












