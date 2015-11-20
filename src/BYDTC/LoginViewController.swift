//
//  LoginViewController.swift
//  BYDTC
//
//  Created by Christopher Cornejo on 11/11/15.
//  Copyright (c) 2015 Clemson University. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController, UITextFieldDelegate {
    

    
    override func viewDidLoad() {


    }



    //Hides the keyboard when white space is touched.
    //Ack: Tony Abboud. https://www.youtube.com/watch?v=cAQtOsfkD5A

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    
        self.view.endEditing(true)
    }



}