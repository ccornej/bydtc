//
//  Events.swift
//  BYDTC
//
//  Created by Evan Dorn on 11/23/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import Foundation
import CoreData

class Events: NSManagedObject {
    
    @NSManaged var capacity: NSNumber
    @NSManaged var room: String
    @NSManaged var desc: String
    @NSManaged var enrolled: NSNumber
    @NSManaged var going: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var lat: Double
    @NSManaged var lon: Double
    @NSManaged var name: String
    @NSManaged var time: NSNumber
    
}
