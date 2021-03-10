//
//  StatePatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/10.
//

import UIKit

class StatePatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = ContextS()
        
        let startStart = StartState()
        startStart.doAction(with: context)
        print((context.getState() as? StartState)?.toString())

        let stopState = StopState()
        stopState.doAction(with: context)
        print((context.getState() as? StopState)?.toString())
        
        
        
    }
    
}
