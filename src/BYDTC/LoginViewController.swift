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
    
    @IBOutlet weak var phoneTextField: UITextField!
    
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
        for index in 1...10 {
            let ent = NSEntityDescription.entityForName("Staff", inManagedObjectContext: context)
            var newStaff = Staff(entity: ent!, insertIntoManagedObjectContext: context)
            
            newStaff.id = index
            newStaff.name = "Staff \(index)"
            newStaff.info = "A staff member"
            // newStaff is !NULL
            newStaff.email = "staffmember\(index)@clemson.edu"
            newStaff.phone = "864-337-2354"
            newStaff.title = "Coordinator of event \(index)"
        }
        
        
        // hunts for loop
        for index in 1...10 {
            
            let ent = NSEntityDescription.entityForName("Hunts", inManagedObjectContext: context)
            var newHunt = Hunts(entity: ent!, insertIntoManagedObjectContext: context)
            newHunt.id = index
            newHunt.name = "Hunt \(index)"
            newHunt.found = 0
            newHunt.clue1 = "This is the discription for Hunt item \(index). This is item is near Tillman hall. There is a green bush. And a roundabout. This item is a tall metal object. It's silver......it resembles a person."
        }
    }

    //Hides the keyboard when white space is touched.
    //Ack: Tony Abboud. https://www.youtube.com/watch?v=cAQtOsfkD5A

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
 
    
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
}