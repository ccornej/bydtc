//
//  HomeViewController.swift
//  BYDTC
//
//  Created by Bradley Kennedy on 12/6/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import Foundation
import Alamofire

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
<<<<<<< HEAD
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appBecomeActive", name: UIApplicationWillEnterForegroundNotification, object: nil )
=======
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
        //var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //var context: NSManagedObjectContext = appDel.managedObjectContext!
       // var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        // var context: NSManagedObjectContext = appDel.managedObjectContext!
       /*
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        var results = context.executeFetchRequest(request, error: nil)!
        var user: Users = results[0] as! Users
        */
        //loadData(0, appDel: appDel, context: context)
        super.viewDidLoad()
            }
    
    override func viewWillAppear(animated: Bool) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        super.viewWillAppear(animated)
        //loadData(0, appDel: appDel, context: context)
        
        var request = NSFetchRequest(entityName: "Users")
        
       //delay(2.0) {
            request.returnsObjectsAsFaults = false
            var results = context.executeFetchRequest(request, error: nil)!
            var user: Users = results[0] as! Users
            self.welcomeLabel?.text = "Welcome, \(user.name)!"
<<<<<<< HEAD
            loadData(user.id, appDel: appDel, context: context)
        
        // }
    }
    func appBecomeActive() {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        //loadData(0, appDel: appDel, context: context)
        
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        var results = context.executeFetchRequest(request, error: nil)!
        var user: Users = results[0] as! Users
        self.welcomeLabel?.text = "Welcome, \(user.name)!"
        loadData(user.id, appDel: appDel, context: context)
    }
=======
        // }
    }
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
<<<<<<< HEAD
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
                                println("deleted event")
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
                        } else if(intDel == 0){
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
=======
>>>>>>> 0112db35199b5059e7f732b3e8d08f2329320b60
    
}