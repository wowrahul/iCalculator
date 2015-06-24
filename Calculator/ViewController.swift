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
    
    var operandStack =  Array<Double>()
    
    @IBAction func Enter() {
        userIsEditing = false
        operandStack.append(DisplayText)
        println("OperandStack = \(operandStack)")
        
    }
    
    
    @IBAction func Operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsEditing {
            Enter()
        }
        switch operation
        {
        case "➗": performOperation {$0 / $1}
        case "✖️": performOperation {$0 * $1}
        case "➖": performOperation {$0 - $1}
        case "➕": performOperation {$0 + $1}
        case "√" : performOperation {sqrt($0) }
        default: break
            
        }
    }
    
    // Using functional programming clojure concept to pass expressions/functions as parameters
    func performOperation(operation:(Double,Double) -> Double)
    {
        if operandStack.count > 1
        {
            DisplayText = operation (operandStack.removeLast() , operandStack.removeLast())
            Enter()
        }
    }

    func performOperation(operation:Double -> Double)
    {
        if operandStack.count > 0
        {
            DisplayText = operation (operandStack.removeLast())
            Enter()
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

