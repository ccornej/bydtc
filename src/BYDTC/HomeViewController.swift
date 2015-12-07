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
        // }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}