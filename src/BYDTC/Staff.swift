//
//  Staff.swift
//  BYDTC
//
//  Created by Evan Dorn on 11/23/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import Foundation
import CoreData

class Staff: NSManagedObject {
    
    @NSManaged var email: String
    @NSManaged var name: String
    @NSManaged var id: NSNumber
    @NSManaged var info: String
    @NSManaged var phone: String
    @NSManaged var title: String
    
}
