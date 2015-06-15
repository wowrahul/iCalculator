//
//  ViewController.swift
//  Calculator
//
//  Created by Rahul Joshi on 6/13/15.
//  Copyright (c) 2015 Rahul Joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

  
    @IBOutlet weak var display: UILabel!
    
    var userIsEditing :Bool = false

    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        if userIsEditing {
            display.text! += digit
        }
        else
        {
            display.text = digit
            userIsEditing = true
        }
        
    }
}

