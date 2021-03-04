//
//  StrategyPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/4.
//

import UIKit

class StrategyPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        var context = Context(with: OperationAdd())
        guard let result1 = context.executeStrategy(with: 10, with: 5) else {
            return
        }
        print("10 + 5 = \(result1)")
        
        context = Context(with: OperationSubtract())
        guard let result2 = context.executeStrategy(with: 10, with: 5) else {
            return
        }
        print("10 - 5 = \(result2)")
        
        context = Context(with: OperationMultiply())
        guard let result3 = context.executeStrategy(with: 10, with: 5) else {
            return
        }
        print("10 * 5 = \(result3)")
    }

}
