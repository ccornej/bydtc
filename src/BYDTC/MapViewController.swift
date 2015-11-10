//
//  MapView.swift
//  BYDTC
//
//  Created by Evan Dorn on 11/10/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

/*
* NOTE: You can find Longitude & Latitude values using Google maps by searching
*   Then right clicking and selection "what's here"
*/

/*
*  NOTE: To access the user's location, you must add the CoreLocation library in the build settins
*/

/*
* NOTE: if you want to request User's location need to add
*
* NSLocationWhenInUseUsageDescription for regular use and --
* NSLocationAlwaysUsageDescription for background use in the info.plist file
*/


import Foundation
import MapKit
import CoreLocation

// MKMapViewDelegate and MapKit API needed for associated methods
// CLLocationManagerDelegate allows for functions needed to get user's location
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest           // Best location Accuracy (uses more battery)
        // (Note) requestAlwaysAuthorization is the 2nd option
        locationManager.requestWhenInUseAuthorization()                     // Will only access the user's location when the app is running
        locationManager.startUpdatingLocation()                             // begins updating the user's location if they have given premissions
        
        /*
        * Part 1: Setting the Map
        */
        
        // Latitude & Longitude for Clemson
        var latitude: CLLocationDegrees = 34.6783          // type is needed to use as coordinate
        var longitude: CLLocationDegrees = -82.8392
        
        // Differnce between latitudes from one side of the screen to the other.
        // Effectively zooms in
        var latitudeDelta: CLLocationDegrees = 0.01
        var longitudeDelta: CLLocationDegrees = 0.01
        
        // Construct Map Region
        // Span and location need deltas and long & lat values
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        // Define what portion of the map to display
        // MKCoordinateRegionMake needs location and span
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        // set the map region and have it animated
        map.setRegion(region, animated: true)
        
        
        /*
        * Part 2: Annotations  (The little red pins)
        */
        
        // Default annotations
        // Create an annotation
        var annotation = MKPointAnnotation()
        annotation.coordinate = location                // set coordinate to the location
        annotation.title = "Clemson University"         // set title information
        annotation.subtitle = "Welcome to Clemson"
        
        // Add the annotation to the map
        map.addAnnotation(annotation)
        
        // User added annotations (by pressing on the screen) using gestures
        
        // target "self" is the view controller
        // in the action need a : within the title to call the method mapAction
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "mapAction:")
        
        // Number of seconds the user has to hold down to get the gesture recognized
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)        // add the gesture to the map
    }
    
    func mapAction(gestureRecognizer: UIGestureRecognizer) {
        println("Gesture Recognized")
        
        // Place where the user has done the long press on the screen
        var touchPoint = gestureRecognizer.locationInView(self.map)         // View Controller's map
        
        // Add the new Coordinate
        var newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = newCoordinate
        
        annotation.title = "My Dropped pin"
        annotation.subtitle = "You are here"
        
        map.addAnnotation(annotation)
    }
    
    
    // Handle user movement on the map
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        // println(locations)
        
        var userLocation: CLLocation = locations[0] as! CLLocation               // Will give you the first location returned by location manager
        
        // extract the lat and long values from the locations arrays
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.05
        var longDelta: CLLocationDegrees = 0.05
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.map.setRegion(region, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
