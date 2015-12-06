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
    
    override func viewDidLoad() {
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
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



}