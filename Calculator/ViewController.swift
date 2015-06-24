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
    var brain =  CalculatorBrain()
    

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
    
    
    
    @IBAction func Enter() {
        userIsEditing = false
        if let result =  brain.pushOperand(DisplayText) {
            DisplayText = result
        } else
        {
            DisplayText = 0
        }
        
    }
    
    
    @IBAction func Operate(sender: UIButton) {
        
        if userIsEditing {
            Enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                DisplayText = result
            } else
            {
                DisplayText = 0
            }
        }
        
    }
    
    
    
    var DisplayText : Double
    {
        get
        { return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set
        {
            display.text = "\(newValue)"
            userIsEditing = false
            
        }
    }
}

