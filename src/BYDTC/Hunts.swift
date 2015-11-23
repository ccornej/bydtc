//
//  Hunts.swift
//  BYDTC
//
//  Created by Evan Dorn on 11/23/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import Foundation
import CoreData

class Hunts: NSManagedObject {
    
    @NSManaged var clue1: String
    @NSManaged var clue2: String
    @NSManaged var clue3: String
    @NSManaged var desc: String
    @NSManaged var id: NSNumber
    @NSManaged var lat: AnyObject
    @NSManaged var lon: AnyObject
    @NSManaged var name: String
    
}
