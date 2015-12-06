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
    
    override func viewDidLoad() {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
       /*
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        var results = context.executeFetchRequest(request, error: nil)!
        var user: Users = results[0] as! Users
        */
        loadData(0, appDel: appDel, context: context)
    }
    func loadData(id: NSNumber, appDel: AppDelegate, context: NSManagedObjectContext){
        var urlString = "http://people.cs.clemson.edu/~bckenne/getAllEvents.php"
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        println(urlString)
        Alamofire.request(.GET, urlString, parameters: nil).responseJSON {
            (request, response, JSON, error) in
            //println(request)
            //println(response)
            println(JSON!)
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
                        if(results.count > 0){
                            var event: Events = results[0] as! Events
                            event.setValue(stringName, forKey: "name")
                            event.setValue(stringDesc, forKey: "desc")
                            event.setValue(stringRoom, forKey: "room")
                            event.setValue(intTime, forKey: "time")
                            event.setValue(intCap, forKey: "capacity")
                            event.setValue(intEnr, forKey: "enrolled")
                            event.setValue(dubLon, forKey: "lon")
                            event.setValue(dubLat, forKey: "lat")
                        }
                        else{
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
                        }
                    }
                    context.save(nil)
                }
            }
        }
        
    }
    
}