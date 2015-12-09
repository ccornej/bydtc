//
//  LoginViewController.swift
//  BYDTC
//
//  Created by Christopher Cornejo on 11/11/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import Foundation
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBAction func startSpinning(sender: AnyObject) {
        activityIndicatorView.hidden = false
        activityIndicatorView.startAnimating()
    }
    
    @IBAction func goButton(sender: AnyObject) {
        println("We are in prepare for segue")
            println("We are in if statement")
            var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context: NSManagedObjectContext = appDel.managedObjectContext!
            var badNum = 1
            print("checking external db for user")
            let phoneNumber: String = phoneTextField.text
            var urlString = "http://people.cs.clemson.edu/~bckenne/getMyInfo.php?&phone=\(phoneNumber)"
            urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            println(urlString)
            Alamofire.request(.GET, urlString, parameters: nil).responseJSON {
                (request, response, JSON, error) in
                //println(request)
                //println(response)
                //println(JSON!)
                var intID: Int = 0
                if(JSON!.count == 0) {
                    println("no JSON data")
                    badNum = 1
                    self.activityIndicatorView.hidden = true
                    self.activityIndicatorView.stopAnimating()
                    let alert = UIAlertController(title: "Error!", message: "Could not find user associated with this phone number.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    badNum = 0
                    let ent = NSEntityDescription.entityForName("Users", inManagedObjectContext: context)
                    var request = NSFetchRequest(entityName: "Users")
                    
                    request.returnsObjectsAsFaults = false
                    var results = context.executeFetchRequest(request, error: nil)!
<<<<<<< HEAD
=======
                    println("1")
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
                    let item: AnyObject = JSON![0]
                    
                    let id: AnyObject? = item["id"]
                    let stringID = "\(id!)"
                    intID = stringID.toInt()!
                    
                    let name: AnyObject? = item["firstName"]
                    let stringName = "\(name!)"
<<<<<<< HEAD
                    if(results.count > 0) {
=======
                    println("2")
                    if(results.count > 0) {
                        println("4")
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
                        var oldUser:Users = results[0] as! Users
                        oldUser.setValue(intID, forKey: "id")
                        oldUser.setValue(stringName, forKey: "name")
                        oldUser.setValue(phoneNumber, forKey: "phone")
<<<<<<< HEAD
                    } else {
=======
                        println("4.5")
                    } else {
                        println("5")
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
                        var newUser = Users(entity: ent!, insertIntoManagedObjectContext: context)
                        newUser.phone = phoneNumber
                        newUser.name = stringName
                        newUser.id = intID
                    }
<<<<<<< HEAD
                    context.save(nil)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("Nav") as! UINavigationController
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.hidden = true
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                }
                if(badNum == 0){
                    //self.loadData(intID, appDel: appDel, context: context)
                    //self.delay(3.0) {
                        
                    //}
=======
                    println("6")
                    context.save(nil)
                    
                    println("7")
                }
                println("8")
                println("3")
                if(badNum == 0){
                    self.loadData(intID, appDel: appDel, context: context)
                    self.delay(5.0) {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("Nav") as! UINavigationController
                        self.activityIndicatorView.stopAnimating()
                        self.activityIndicatorView.hidden = true
                        self.presentViewController(vc, animated: true, completion: nil)
                    }
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
                }
                
            }
        
    }
    func loadData(id: NSNumber, appDel: AppDelegate, context: NSManagedObjectContext) {
        var urlString = "http://people.cs.clemson.edu/~bckenne/getAllEvents.php"
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        println(urlString)
        Alamofire.request(.GET, urlString, parameters: nil).responseJSON {
            (request, response, JSON, error) in
            //println(request)
            //println(response)
            //println(JSON!)
            if(JSON!.count == 0){
                println("no JSON data")
            }
            else{
                var request = NSFetchRequest(entityName: "Events")
                request.returnsObjectsAsFaults = false
                var results = context.executeFetchRequest(request, error: nil)!
                for index in 0 ... (JSON!.count - 1) {
                    if let item: AnyObject = JSON![index]{
                        
                        let id: AnyObject? = item["id"]
                        let stringID = "\(id!)"
                        let intID = stringID.toInt()!
                        
                        let name: AnyObject? = item["name"]
                        let stringName = "\(name!)"
                        
                        let desc: AnyObject? = item["description"]
                        let stringDesc = "\(desc!)"
                        
                        let room: AnyObject? = item["room"]
                        let stringRoom = "\(room!)"
                        
                        let time: AnyObject? = item["time"]
                        let stringTime = "\(time!)"
                        let intTime = stringTime.toInt()!
                        
                        let cap: AnyObject? = item["capacity"]
                        let stringCap = "\(cap!)"
                        let intCap = stringCap.toInt()!
                        
                        let enrolled: AnyObject? = item["enrolled"]
                        let stringEnr = "\(enrolled!)"
                        let intEnr = stringEnr.toInt()!
                        
                        let lon: AnyObject? = item["longitude"]
                        let stringLon = "\(lon!)"
                        let dubLon = (stringLon as NSString).doubleValue
                        
                        let lat: AnyObject? = item["latitude"]
                        let stringLat = "\(lat!)"
                        let dubLat = (stringLat as NSString).doubleValue
                        
                        let del: AnyObject? = item["deleted"]
                        let stringDel = "\(del!)"
                        let intDel = stringDel.toInt()!
                        
                        let predicate = NSPredicate(format: "id == %d", intID)
                        request.predicate = predicate;
                        var results = context.executeFetchRequest(request, error: nil)!
                        if(results.count > 0) {
                            var event: Events = results[0] as! Events
                            
                            if(intDel != 0) {
                                context.deleteObject(event)
                            } else {
                                event.setValue(stringName, forKey: "name")
                                event.setValue(stringDesc, forKey: "desc")
                                event.setValue(stringRoom, forKey: "room")
                                event.setValue(intTime, forKey: "time")
                                event.setValue(intCap, forKey: "capacity")
                                event.setValue(intEnr, forKey: "enrolled")
                                event.setValue(dubLon, forKey: "lon")
                                event.setValue(dubLat, forKey: "lat")
                                event.setValue(0, forKey: "going")
                            }
                        } else {
                            let ent = NSEntityDescription.entityForName("Events", inManagedObjectContext: context)
                            var newEvent = Events(entity: ent!, insertIntoManagedObjectContext: context)
                            newEvent.name = stringName
                            newEvent.desc = stringDesc
                            newEvent.room = stringRoom
                            newEvent.time = intTime
                            newEvent.capacity = intCap
                            newEvent.enrolled = intEnr
                            newEvent.lon = dubLon
                            newEvent.lat = dubLat
                            newEvent.going = 0
                            newEvent.id = intID
                            newEvent.going = 0
                        }
                    }
                    context.save(nil)
                }
            }
            urlString = "http://people.cs.clemson.edu/~bckenne/getMyEvents.php?&id=\(id)"
            urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            println(urlString)
            Alamofire.request(.GET, urlString, parameters: nil).responseJSON {
                (request, response, JSON, error) in
                //println(request)
                //println(response)
                if(JSON!.count == 0){
                    println("no JSON data")
                }
                else{
                    println(JSON!)
                    var request = NSFetchRequest(entityName: "Events")
                    request.returnsObjectsAsFaults = false
                    var results = context.executeFetchRequest(request, error: nil)!
                    for index in 0 ... (JSON!.count - 1) {
                        if let item: AnyObject = JSON![index]{
                            
                            let eventID: AnyObject? = item["eventId"]
                            let stringEventID = "\(eventID!)"
                            let intEventID = stringEventID.toInt()!
                            
                            let predicate = NSPredicate(format: "id == %d", intEventID)
                            request.predicate = predicate;
                            var results = context.executeFetchRequest(request, error: nil)!
                            if(results.count > 0) {
                                var event: Events = results[0] as! Events
                                
                                event.setValue(1, forKey: "going")
                            }
                        }
                        context.save(nil)
                    }
                }
            }

        }
        urlString = "http://people.cs.clemson.edu/~bckenne/getAllStaff.php"
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        println(urlString)
        Alamofire.request(.GET, urlString, parameters: nil).responseJSON {
            (request, response, JSON, error) in
            //println(request)
            //println(response)
            
            if(JSON!.count == 0){
                println("no JSON data")
                //println(JSON!)
            }
            else{
                var request = NSFetchRequest(entityName: "Staff")
                request.returnsObjectsAsFaults = false
                var results = context.executeFetchRequest(request, error: nil)!
                for index in 0 ... (JSON!.count - 1) {
                    if let item: AnyObject = JSON![index]{
                        
                        let id: AnyObject? = item["id"]
                        let stringID = "\(id!)"
                        let intID = stringID.toInt()!
                        
                        let name: AnyObject? = item["name"]
                        let stringName = "\(name!)"
                        
                        let title: AnyObject? = item["title"]
                        let stringTitle = "\(title!)"
                        
                        let info: AnyObject? = item["info"]
                        let stringInfo = "\(info!)"
                        
                        let email: AnyObject? = item["email"]
                        let stringEmail = "\(email!)"
                        
                        let phone: AnyObject? = item["phone"]
                        let stringPhone = "\(phone!)"
                        
                        let del: AnyObject? = item["deleted"]
                        let stringDel = "\(del!)"
                        let intDel = stringDel.toInt()!
                        
                        let predicate = NSPredicate(format: "id == %d", intID)
                        request.predicate = predicate;
                        var results = context.executeFetchRequest(request, error: nil)!
                        if(results.count > 0) {
                            var staff: Staff = results[0] as! Staff
                            
                            if(intDel != 0) {
                                context.deleteObject(staff)
                            } else {
                                staff.setValue(stringName, forKey: "name")
                                staff.setValue(stringTitle, forKey: "title")
                                staff.setValue(stringInfo, forKey: "info")
                                staff.setValue(stringEmail, forKey: "email")
                                staff.setValue(stringPhone, forKey: "phone")
                            }
                        } else if(intDel == 0){
                            let ent = NSEntityDescription.entityForName("Staff", inManagedObjectContext: context)
                            var newStaff = Staff(entity: ent!, insertIntoManagedObjectContext: context)
                            newStaff.name = stringName
                            newStaff.id = intID
                            newStaff.email = stringEmail
                            newStaff.info = stringInfo
                            newStaff.phone = stringPhone
                            newStaff.title = stringTitle
                        }
                    }
                    context.save(nil)
                }
            }
        }
        urlString = "http://people.cs.clemson.edu/~bckenne/getAllHunts.php"
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        println(urlString)
        Alamofire.request(.GET, urlString, parameters: nil).responseJSON {
            (request, response, JSON, error) in
            //println(request)
            //println(response)
            if(JSON!.count == 0){
                println("no JSON data")
            }
            else{
                //println(JSON!)
                var request = NSFetchRequest(entityName: "Hunts")
                request.returnsObjectsAsFaults = false
                var results = context.executeFetchRequest(request, error: nil)!
                for index in 0 ... (JSON!.count - 1) {
                    if let item: AnyObject = JSON![index]{
                        
                        let id: AnyObject? = item["id"]
                        let stringID = "\(id!)"
                        let intID = stringID.toInt()!
                        
                        let name: AnyObject? = item["name"]
                        let stringName = "\(name!)"
                        
                        let desc: AnyObject? = item["description"]
                        let stringDesc = "\(desc!)"
                        
                        let clue1: AnyObject? = item["clue1"]
                        let stringClue1 = "\(clue1!)"
                        
                        let clue2: AnyObject? = item["clue2"]
                        let stringClue2 = "\(clue2!)"
                        
                        let clue3: AnyObject? = item["clue3"]
                        let stringClue3 = "\(clue3!)"
                        
                        let lon: AnyObject? = item["longitude"]
                        let stringLon = "\(lon!)"
                        let dubLon = (stringLon as NSString).doubleValue
                        
                        let lat: AnyObject? = item["latitude"]
                        let stringLat = "\(lat!)"
                        let dubLat = (stringLat as NSString).doubleValue
                        
                        let del: AnyObject? = item["deleted"]
                        let stringDel = "\(del!)"
                        let intDel = stringDel.toInt()!
                        
                        let predicate = NSPredicate(format: "id == %d", intID)
                        request.predicate = predicate;
                        var results = context.executeFetchRequest(request, error: nil)!
                        if(results.count > 0) {
                            var hunt: Hunts = results[0] as! Hunts
                            
                            if(intDel != 0) {
                                context.deleteObject(hunt)
                            } else {
                                hunt.setValue(stringName, forKey: "name")
                                hunt.setValue(stringDesc, forKey: "desc")
                                hunt.setValue(stringClue1, forKey: "clue1")
                                hunt.setValue(stringClue2, forKey: "clue2")
                                hunt.setValue(stringClue3, forKey: "clue3")
                                hunt.setValue(dubLon, forKey: "lon")
                                hunt.setValue(dubLat, forKey: "lat")
                                hunt.setValue(0, forKey: "found")
                            }
                        } else if(intDel == 0){
                            let ent = NSEntityDescription.entityForName("Hunts", inManagedObjectContext: context)
                            var newHunt = Hunts(entity: ent!, insertIntoManagedObjectContext: context)
                            newHunt.name = stringName
                            newHunt.id = intID
                            newHunt.desc = stringDesc
                            newHunt.lat = dubLat
                            newHunt.lon = dubLon
                            newHunt.clue1 = stringClue1
                            newHunt.clue2 = stringClue2
                            newHunt.clue3 = stringClue3
                            newHunt.found = 0
                        }
                    }
                    context.save(nil)
                }
            }
            urlString = "http://people.cs.clemson.edu/~bckenne/getMyHunts.php?&id=\(id)"
            urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            println(urlString)
            Alamofire.request(.GET, urlString, parameters: nil).responseJSON {
                (request, response, JSON, error) in
                //println(request)
                //println(response)
                if(JSON!.count == 0){
                    println("no JSON data")
                }
                else{
                    //println(JSON!)
                    var request = NSFetchRequest(entityName: "Hunts")
                    request.returnsObjectsAsFaults = false
                    var results = context.executeFetchRequest(request, error: nil)!
                    for index in 0 ... (JSON!.count - 1) {
                        if let item: AnyObject = JSON![index]{
                            
                            let huntID: AnyObject? = item["huntId"]
                            let stringHuntID = "\(huntID!)"
                            let intHuntID = stringHuntID.toInt()!
                            println("\(intHuntID)");
                            let predicate = NSPredicate(format: "id == %d", intHuntID)
                            request.predicate = predicate;
                            var results = context.executeFetchRequest(request, error: nil)!
                            println("result hunt count: \(results.count)")
                            if(results.count > 0) {
                                println("hunt found")
                                var hunt: Hunts = results[0] as! Hunts
                                
                                hunt.setValue(1, forKey: "found")
                            }
                        }
                        context.save(nil)
                    }
                }
            }
        }
        
    }

    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    
    /*
    @IBAction func goButton(sender: AnyObject) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!

        print("checking external db for user")
        let phoneNumber: String = phoneTextField.text
        var urlString = "http://people.cs.clemson.edu/~bckenne/getMyInfo.php?&phone=\(phoneNumber)"
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        println(urlString)
        Alamofire.request(.GET, urlString, parameters: nil).responseJSON {
            (request, response, JSON, error) in
            //println(request)
            //println(response)
            println(JSON!)
            if(JSON!.count == 0) {
                println("no JSON data")
                let alert = UIAlertController(title: "Error!", message: "Could not find user associated with this phone number.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                let ent = NSEntityDescription.entityForName("Users", inManagedObjectContext: context)
                
                /*
                if(newUser ) {
                }
                */
                
                var newUser = Users(entity: ent!, insertIntoManagedObjectContext: context)
                newUser.phone = phoneNumber
                if let item: AnyObject = JSON![0] {
                    if let id: AnyObject? = item["id"] {
                        let stringID = "\(id!)"
                        let intID = stringID.toInt()!
                        newUser.id = intID
                    }
                    if let name: AnyObject? = item["firstName"] {
                        let stringName = "\(name!)"
                        newUser.name = stringName
                    }
                }
                context.save(nil)
            }
            var request = NSFetchRequest(entityName: "Users")
            request.returnsObjectsAsFaults = false
            var results = context.executeFetchRequest(request, error: nil)!
            var user: Users = results[0] as! Users
            println("Fetched the user")
            println("id: \(user.id)")
            println("name: \(user.name)")
            println("phone: \(user.phone)")
        }
    }
*/
    
    override func viewDidLoad() {
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        
        // var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
       // var context: NSManagedObjectContext = appDel.managedObjectContext!
        /*
        
        // Events for loop
        for index in 1...10 {
            
            let ent = NSEntityDescription.entityForName("Events", inManagedObjectContext: context)
            var newEvent = Events(entity: ent!, insertIntoManagedObjectContext: context)
            newEvent.id = index
            newEvent.name = "Event \(index)"
            newEvent.desc = "The description of Event \(index)"
            newEvent.room = "Building Room 999"
            newEvent.enrolled = 0
            newEvent.capacity = 20
            newEvent.time = 800 + (index * 100)
            newEvent.lat = 34.6783
            newEvent.lon = -82.8392
            newEvent.going = 0
        }
*/
        
        // Staff for loop
        /*for index in 1...10 {
            let ent = NSEntityDescription.entityForName("Staff", inManagedObjectContext: context)
            var newStaff = Staff(entity: ent!, insertIntoManagedObjectContext: context)
            
            newStaff.id = index
            newStaff.name = "Staff \(index)"
            newStaff.info = "A staff member"
            // newStaff is !NULL
            newStaff.email = "staffmember\(index)@clemson.edu"
            newStaff.phone = "864-337-2354"
            newStaff.title = "Coordinator of event \(index)"
        }*/
        
        
        // hunts for loop
        /*for index in 1...10 {
            
            let ent = NSEntityDescription.entityForName("Hunts", inManagedObjectContext: context)
            var newHunt = Hunts(entity: ent!, insertIntoManagedObjectContext: context)
            newHunt.id = index
            newHunt.name = "Hunt \(index)"
            newHunt.found = 0
            newHunt.clue1 = "This is the discription for Hunt item \(index). This is item is near Tillman hall. There is a green bush. And a roundabout. This item is a tall metal object. It's silver......it resembles a person."
        }*/
    }

    //Hides the keyboard when white space is touched.
    //Ack: Tony Abboud. https://www.youtube.com/watch?v=cAQtOsfkD5A

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
 
/*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        println("We are in prepare for segue")
        if segue.identifier == "LoginSegue" {
            println("We are in if statement")
            var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context: NSManagedObjectContext = appDel.managedObjectContext!
            
            print("checking external db for user")
            let phoneNumber: String = phoneTextField.text
            var urlString = "http://people.cs.clemson.edu/~bckenne/getMyInfo.php?&phone=\(phoneNumber)"
            urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            println(urlString)
            Alamofire.request(.GET, urlString, parameters: nil).responseJSON {
                (request, response, JSON, error) in
                //println(request)
                //println(response)
                println(JSON!)
                if(JSON!.count == 0) {
                    println("no JSON data")
                    let alert = UIAlertController(title: "Error!", message: "Could not find user associated with this phone number.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    let ent = NSEntityDescription.entityForName("Users", inManagedObjectContext: context)
                    var request = NSFetchRequest(entityName: "Users")
                    
                    request.returnsObjectsAsFaults = false
                    var results = context.executeFetchRequest(request, error: nil)!
                    
                    let item: AnyObject = JSON![0]
                    
                    let id: AnyObject? = item["id"]
                    let stringID = "\(id!)"
                    let intID = stringID.toInt()!
                    
                    let name: AnyObject? = item["firstName"]
                    let stringName = "\(name!)"
                    
                    if(results.count > 0) {
                        var oldUser:Users = results[0] as! Users
                        oldUser.setValue(intID, forKey: "id")
                        oldUser.setValue(stringName, forKey: "name")
                        oldUser.setValue(phoneNumber, forKey: "phone")
                    } else{
                        var newUser = Users(entity: ent!, insertIntoManagedObjectContext: context)
                        newUser.phone = phoneNumber
                        newUser.name = stringName
                        newUser.id = intID
                    }
                    context.save(nil)
                }
                var request = NSFetchRequest(entityName: "Users")
                request.returnsObjectsAsFaults = false
                var results = context.executeFetchRequest(request, error: nil)!
                var user: Users = results[0] as! Users
                println("Fetched the user")
                println("id: \(user.id)")
                println("name: \(user.name)")
                println("phone: \(user.phone)")
                
              }
            }
        }
*/
}