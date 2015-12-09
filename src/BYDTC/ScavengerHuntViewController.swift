//
//  ScavengerHuntViewController.swift
//  BYDTC
//
//  Created by Evan Dorn on 11/23/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ScavengerHuntViewController: UITableViewController {
    
    // Class variables
    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    var context: NSManagedObjectContext!
    var request: NSFetchRequest!
    var results: NSArray = []
    var totalHuntItems: Int = 0
    var sortedResults: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        self.tableView.reloadData()
    }

    
    // Load data from Core Data
    func loadData() {
        context = appDel.managedObjectContext
        var request = NSFetchRequest(entityName: "Hunts")
        request.returnsObjectsAsFaults = false
        results = context.executeFetchRequest(request, error: nil)!
        totalHuntItems = results.count
        sortArray()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return totalHuntItems
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    // Sort array for times to display the events based on scavenger hunt ID
    func sortArray() {
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        if(totalHuntItems > 0) {
            sortedResults = results.sortedArrayUsingDescriptors([sortDescriptor])
        }
        // tableView.reloadData()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ScavengerHuntCell = tableView.dequeueReusableCellWithIdentifier("huntCell", forIndexPath: indexPath) as! ScavengerHuntCell
        
        cell.huntItemLabel?.text = "\((sortedResults[indexPath.row] as! Hunts).name)"               // Hunt item name (title)
    
        var foundString: String = " "
        
        
        // Item hasn't been found display empty text
        if((sortedResults[indexPath.row] as! Hunts).found == 0) {
            foundString = " "
            // Else display these awesome emojis
        } else {
            foundString = "✅💁😄"
        }
        
        cell.foundStatusLabel?.text = foundString
        
        // else item has been found display awesome emojis
     /*   if((sortedResults[indexPath.row] as! Hunts).found == 1) {
            cell.foundStatusLabel?.text = "💁😄✅"
        } 
      */
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // Debugging for a Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Segue to the HuntItemDiscriptionViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "huntItemSegue" {
            if let destination = segue.destinationViewController as? HuntItemDiscriptionViewController {
                if let cellIndex = tableView.indexPathForSelectedRow()?.row {
                    destination.huntItemID = (sortedResults[cellIndex] as! Hunts).id as Int
                }
            }
        }
    }
}
