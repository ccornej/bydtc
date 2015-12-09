//
//  ScavengerHuntCell.swift
//  BYDTC
//
//  Created by Evan Dorn on 11/23/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ScavengerHuntCell: UITableViewCell {
    
    @IBOutlet weak var foundStatusLabel: UILabel!
    @IBOutlet weak var huntItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
