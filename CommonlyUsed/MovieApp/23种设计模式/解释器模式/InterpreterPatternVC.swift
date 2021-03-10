//
//  InterpreterPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/10.
//

import UIKit

class InterpreterPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        let isMale = getMaleExpression()
        let isMarriedWoman = getMarriedWomanExpression()
        
        print("John is male? \(isMale.interpret(with: "John"))")
        print("Julie is a married women? \(isMarriedWoman.interpret(with: "Married Julie"))")
        
        
    }
    
    //规则：Robert 和 John 是男性
    func getMaleExpression() -> Expression {
        let robert = TerminalExpression(with: "Robert")
        let john = TerminalExpression(with: "John")
        return OrExpression(with: robert, with: john)
    }
    
    //规则：Julie 是一个已婚的女性
    func getMarriedWomanExpression() -> Expression {
        let julie = TerminalExpression(with: "Julie")
        let married = TerminalExpression(with: "Married")
        return AndExpression(with: julie, with: married)
    }

}
