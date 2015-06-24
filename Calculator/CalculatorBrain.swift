//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Rahul Joshi on 6/24/15.
//  Copyright (c) 2015 Rahul Joshi. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op{
        case Operand (Double)
        case UnaryOperation (String,Double -> Double)
        case BinaryOperation (String,(Double,Double) -> Double)
        
    }
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    
    init()
    {
        knownOps["✖️"] = Op.BinaryOperation("✖️",*)
        knownOps["➖"] = Op.BinaryOperation("➖") {$0 - $1}
        knownOps["➕"] = Op.BinaryOperation("➕",+)
        knownOps["➗"] = Op.BinaryOperation("➗") {$0 / $1}
        knownOps["√"] =  Op.UnaryOperation("√",sqrt)
        
        
    }
    
    private func evaluate(ops: [Op]) -> ( result: Double?, remainingOps: [Op])
    {
       
        if !ops.isEmpty {
            
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                    return (operand,remainingOps)
            case .UnaryOperation(_, let operation):
                  let operandEvaluation = evaluate(remainingOps)
                  if let operand = operandEvaluation.result {
                    return (operation(operand),operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil,ops)
        
    }
    
    func evaluate() -> Double?
    {
        let (result,remainder) = evaluate(opStack)
        return result
    }
    func pushOperand(operand: Double) -> Double?
    {
        opStack.append(Op.Operand(operand))
        
        return evaluate()
    }
    
    func performOperation (symbol: String) -> Double?
    {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
}
