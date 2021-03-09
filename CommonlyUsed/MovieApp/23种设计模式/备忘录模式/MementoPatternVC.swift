//
//  MementoPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/9.
//

import UIKit

class MementoPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let originator = Originator()
        let careTaker = CareTaker()
        originator.setState(with: "State #1")
        originator.setState(with: "State #2")
        careTaker.add(with: originator.saveStateToMemento())
        originator.setState(with: "State #3")
        careTaker.add(with: originator.saveStateToMemento())
        originator.setState(with: "State #4")
        
        print("Current State: \(originator.getState() ?? "")")
        originator.getStateFromMemento(with: careTaker.get(with: 0))
        print("First saved State: \(originator.getState() ?? "")")
        originator.getStateFromMemento(with: careTaker.get(with: 1))
        print("Second saved State:\(originator.getState() ?? "")")
        
    }

}
