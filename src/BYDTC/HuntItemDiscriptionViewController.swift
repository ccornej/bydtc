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

class HuntItemDiscriptionViewController: UIViewController {
    
    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    var context: NSManagedObjectContext!
    var request: NSFetchRequest!
    var results: NSArray = []
    var hunt: Hunts!
    var huntItemID = 0
    
    @IBOutlet weak var huntItemLabel: UILabel!
    @IBOutlet weak var clueItemDiscriptionView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    @IBAction func FoundButton(sender: AnyObject) {
        let alert = UIAlertController(title: "You Found it!", message: "Congradulations! Good Job!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        hunt.setValue(1, forKey: "found")
        context.save(nil)
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
    }

}
