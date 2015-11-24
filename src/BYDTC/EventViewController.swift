//
//  EventViewController.swift
//  BYDTC
//
//  Created by Evan Dorn on 11/23/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EventViewController: UITableViewController {

    // Class variables
    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    var context: NSManagedObjectContext!
    var request: NSFetchRequest!
    var results: NSArray = []
    var totalEvents: Int = 0
    var sortedResults: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    
    // Load data from Core Data
    func loadData() {
        context = appDel.managedObjectContext
        var request = NSFetchRequest(entityName: "Events")
        request.returnsObjectsAsFaults = false
        results = context.executeFetchRequest(request, error: nil)!
        totalEvents = results.count
        sortArray()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return totalEvents
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    // Sort array for times to display the events based on time
    func sortArray() {
        let sortDescriptor = NSSortDescriptor(key: "time", ascending: true)
        if(totalEvents > 0) {
            sortedResults = results.sortedArrayUsingDescriptors([sortDescriptor])
            }
           // tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: EventCell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventCell
        
        cell.eventTitle?.text = "\((sortedResults[indexPath.row] as! Events).name)"       // event name (title)

        // Formatting for time label
        
        var hours: Int = 0
        var minutes: Int = 0
        var timeOfDay = "am"
        hours = Int((sortedResults[indexPath.row] as! Events).time) / 100
        minutes = Int((sortedResults[indexPath.row] as! Events).time) % 100
        
        // Handling for am/pm with 24 hours time
        if(hours > 12) {
            hours = hours - 12
            timeOfDay = "pm"
        }
        
        cell.eventTime?.text = "\(hours):" + String(format: "%02d", minutes) + " " +  timeOfDay       // event time
        
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eventToDetail" {
            if let destination = segue.destinationViewController as? EventDetailViewController {
                if let cellIndex = tableView.indexPathForSelectedRow()?.row {
                    destination.eventid = (sortedResults[cellIndex] as! Events).id as Int
                }
            }
        }
    }
}
