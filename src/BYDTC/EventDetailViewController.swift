//
//  EventDetailViewController.swift
//  BYDTC
//
//  Created by Bradley Kennedy on 11/23/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit
import CoreLocation
import Alamofire

class EventDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
<<<<<<< HEAD
    
=======

>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
    // Class Variables
    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var roomLocation: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var enrolled: UILabel!
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var going: UISegmentedControl!
    @IBAction func goingAction(sender: AnyObject) {
        var managedObject: Events = results[0] as! Events
        if going.selectedSegmentIndex == 0{
            managedObject.setValue(0, forKey: "going")
            if managedObject.enrolled as Int > 0{
                managedObject.setValue((managedObject.enrolled as Int) - 1, forKey: "enrolled")
            }
            var request = NSFetchRequest(entityName: "Users")
            request.returnsObjectsAsFaults = false
            var results = context.executeFetchRequest(request, error: nil)!
            var user: Users = results[0] as! Users
            
            Alamofire.request(.GET, "http://people.cs.clemson.edu/~bckenne/notGoingToEvent.php?&attendeeId=\(user.id)&eventId=\(managedObject.id)&enrolled=\(managedObject.enrolled)", parameters: nil).response { (request,response, data, error) in
                print(request)
                print(response)
                print(error)
            }
            context.save(nil)
        }
        else if going.selectedSegmentIndex == 1 {
            if managedObject.enrolled as Int >= managedObject.capacity as Int{
                
                //we should make an alert pop up here!! MAX CAPACITY SORRY
                
                going.selectedSegmentIndex = 0
            }
            else{
                managedObject.setValue(1, forKey: "going")
                managedObject.setValue((managedObject.enrolled as Int) + 1, forKey: "enrolled")
                var request = NSFetchRequest(entityName: "Users")
                request.returnsObjectsAsFaults = false
                var results = context.executeFetchRequest(request, error: nil)!
                var user: Users = results[0] as! Users
                
                Alamofire.request(.GET, "http://people.cs.clemson.edu/~bckenne/goingToEvent.php?&attendeeId=\(user.id)&eventId=\(managedObject.id)&enrolled=\(managedObject.enrolled)", parameters: nil).response { (request,response, data, error) in
                    print(request)
                    print(response)
                    print(error)
                }
                context.save(nil)
            }
        }
        enrolled.text = "\(managedObject.enrolled)"
    }
    
    
    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    var context: NSManagedObjectContext!
    var request: NSFetchRequest!
    var results: NSArray = []
    var eventid = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK -- Loading Label Data
        loadData()
        if(results.count == 1){
            var hours: Int = 0
            var minutes: Int = 0
            var timeOfDay = "am"
            hours = Int((results[0] as! Events).time) / 100
            minutes = Int((results[0] as! Events).time) % 100
            
            // Handling for am/pm with 24 hours time
            if(hours > 12) {
                hours = hours - 12
                timeOfDay = "pm"
            }
            
            time.text = "\(hours):" + String(format: "%02d", minutes) + " " +  timeOfDay
            roomLocation.text = (results[0] as! Events).room
            enrolled.text = "\((results[0] as! Events).enrolled)"
            capacity.text = "\((results[0] as! Events).capacity)"
            desc.text = (results[0] as! Events).desc
            going.selectedSegmentIndex = (results[0] as! Events).going as Int
            name.text = (results[0] as! Events).name
            
            
            var fetchedLong: Double = (results[0] as! Events).lon
            var fetchedLat: Double = (results[0] as! Events).lat
            
            
            // MARK -- Map Data
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest           // Best location Accuracy (uses more battery)
            // (Note) requestAlwaysAuthorization is the 2nd option
            locationManager.requestWhenInUseAuthorization()                     // Will only access the user's location when the app is running
            locationManager.startUpdatingLocation()                             // begins updating the user's location if they have given premissions
            
            /*
            * Part 1: Setting the Map
            */
            
            // Latitude & Longitude for Clemson
            var latitude: CLLocationDegrees = fetchedLat          // type is needed to use as coordinate
            var longitude: CLLocationDegrees = fetchedLong
            
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
<<<<<<< HEAD
            // annotation.title = "Clemson University"         // set title information
            // annotation.subtitle = "Welcome to Clemson"
            
            map.showsUserLocation = true                   // Show users location as a dot
            
=======
           // annotation.title = "Clemson University"         // set title information
           // annotation.subtitle = "Welcome to Clemson"
            
            map.showsUserLocation = true                   // Show users location as a dot

>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
            
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
        else if(results.count > 1) {
            println("ERROR: Found multiple events with id == \(eventid)")
        }
        else {
            println("ERROR: Could not locate an Event with id == \(eventid)")
        }
        // eventIdLabel.text = "Selected Event ID: \(eventid)"
        
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
<<<<<<< HEAD
    }
=======
    } 
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
    
    // Handle user movement on the map
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        // println(locations)
        
        var userLocation: CLLocation = locations[0] as! CLLocation               // Will give you the first location returned by location manager
        
        // extract the lat and long values from the locations arrays
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.01
        var longDelta: CLLocationDegrees = 0.01
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.map.setRegion(region, animated: false)
    }
    
    func loadData() {
        context = appDel.managedObjectContext
        var request = NSFetchRequest(entityName: "Events")
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "id == %d", eventid)
        request.predicate = predicate;
        results = context.executeFetchRequest(request, error: nil)!
    }
}