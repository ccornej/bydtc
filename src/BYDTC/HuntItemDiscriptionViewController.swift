//
//  HuntItemDiscriptionViewController.swift
//  BYDTC
//
//  Created by Evan Dorn on 12/6/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import Foundation
import UIKit
import CoreData
<<<<<<< HEAD
import MapKit
import CoreLocation
import Alamofire

class HuntItemDiscriptionViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var button: UIButton!
    var locationManager = CLLocationManager()

    var currentLocation: CLLocation!
=======
import Alamofire

class HuntItemDiscriptionViewController: UIViewController {
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
    
    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    var context: NSManagedObjectContext!
    var request: NSFetchRequest!
    var results: NSArray = []
    var hunt: Hunts!
    var huntItemID = 0
    
    @IBOutlet weak var huntItemLabel: UILabel!
    @IBOutlet weak var clueItemDiscriptionView: UITextView!
    
<<<<<<< HEAD
    var databaseLong: Double = 0
    var databaseLat: Double = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.enabled = true
        loadData()
    }
    
    // Location manager
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        // println(locations)
        
        var userLocation: CLLocation = locations[0] as! CLLocation               // Will give you the first location returned by location manager
        
        // extract the lat and long values from the locations arrays
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        
        var location = CLLocation(latitude: latitude, longitude: longitude)
        currentLocation = location
    }

    func handleDistance() -> CLLocationDistance {
        // MARK -- Location Data
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest           // Best location Accuracy (uses more battery)
        // (Note) requestAlwaysAuthorization is the 2nd option
        locationManager.requestWhenInUseAuthorization()                // Will only access the user's location when the app is running
        locationManager.startUpdatingLocation()                      // begins updating the user's location if they have given premissions
        
        
        println(currentLocation)
        
        // hunts data
        var databaseCoords = CLLocation(latitude: databaseLat, longitude: databaseLong)
        var distanceDifference: Double = databaseCoords.distanceFromLocation(currentLocation) as Double
        
        println("inside handleDistance distance = \(distanceDifference)")
        
        return distanceDifference
    }
    

    @IBAction func FoundButton(sender: AnyObject) {
        var found: Bool = false
        
        println("before if found: \(found)")
        println("before if distance: \(handleDistance())")

        if(handleDistance()  <= 50.00 && handleDistance()  >= -50.00) {
            //if location is close enough... use hunt.lon and hunt.lat to compare to current loaction
            found = true
        }
        println("after if found: \(found)")
        if (found == true) {
            let alert = UIAlertController(title: "You Found it!", message: "Congratulations! Good Job!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            hunt.setValue(1, forKey: "found")
            var request = NSFetchRequest(entityName: "Users")
            request.returnsObjectsAsFaults = false
            var results = context.executeFetchRequest(request, error: nil)!
            var user: Users = results[0] as! Users
        
            Alamofire.request(.GET, "http://people.cs.clemson.edu/~bckenne/foundItem.php?&attendeeId=\(user.id)&huntId=\(hunt.id)", parameters: nil).response { (request,response, data, error) in
                print(request)
                print(response)
                print(error)
            }

            context.save(nil)
            self.button.enabled = false
        }
        else{
            let alert = UIAlertController(title: "Uh oh!", message: "Your location does not seem to be close to this item! Maybe you haven't found it yet.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
=======
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    @IBAction func FoundButton(sender: AnyObject) {
        let alert = UIAlertController(title: "You Found it!", message: "Congradulations! Good Job!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        hunt.setValue(1, forKey: "found")
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        var results = context.executeFetchRequest(request, error: nil)!
        var user: Users = results[0] as! Users
        
        Alamofire.request(.GET, "http://people.cs.clemson.edu/~bckenne/foundItem.php?&attendeeId=\(user.id)&huntId=\(hunt.id)", parameters: nil).response { (request,response, data, error) in
            print(request)
            print(response)
            print(error)
        }

        context.save(nil)
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
    }
    
    func loadData() {
        context = appDel.managedObjectContext
        var request = NSFetchRequest(entityName: "Hunts")
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "id == %d", huntItemID)
        request.predicate = predicate;
        results = context.executeFetchRequest(request, error: nil)!
        hunt = results[0] as! Hunts
        clueItemDiscriptionView?.text = hunt.clue1
        huntItemLabel?.text = "Item \(huntItemID)"
<<<<<<< HEAD
        databaseLong = hunt.lon
        databaseLat = hunt.lat
        if(hunt.found == 1){
            self.button.enabled = false
        }
=======
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
    }

}
