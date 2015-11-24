//
//  ContactViewController.swift
//  BYDTC
//
//  Created by Evan Dorn on 11/23/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContactViewController: UITableViewController {
    
    // Class variables
    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    var context: NSManagedObjectContext!
    var request: NSFetchRequest!
    var results: NSArray = []
    var totalStaff: Int = 0
    var sortedResults: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // Load data from Core Data
    func loadData() {
        context = appDel.managedObjectContext
        var request = NSFetchRequest(entityName: "Staff")
        request.returnsObjectsAsFaults = false
        results = context.executeFetchRequest(request, error: nil)!
        totalStaff = results.count
        sortArray()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return totalStaff
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    // Sort array for times to display the events based on time
    func sortArray() {
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        if(totalStaff > 0) {
            sortedResults = results.sortedArrayUsingDescriptors([sortDescriptor])
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ContactCell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as! ContactCell
        
        cell.nameLabel?.text = "\((sortedResults[indexPath.row] as! Staff).name)"
        cell.emailLabel?.text = "\((sortedResults[indexPath.row] as! Staff).email)"
        cell.phoneNumberLabel?.text = "\((sortedResults[indexPath.row] as! Staff).phone)"
        cell.titleLabel?.text = "\((sortedResults[indexPath.row] as! Staff).title)"
        
        return cell
        
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return false
    }
    
    // Debugging for a Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
