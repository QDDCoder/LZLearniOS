//
//  ObserverPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/6.
//

import UIKit

class ObserverPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        var subject = Subject()
        let ho = HexaObserver(with: subject)
        subject.attach(with: ho)
        let oo = OctalObserver(with: subject)
        subject.attach(with: oo)
        let bo = BinaryObserver(with: subject)
        subject.attach(with: bo)
        
        print("第一次状态改变")
        subject.setState(with: 15)
        print("第二次状态改变")
        subject.setState(with: 10)
        
    }

}
