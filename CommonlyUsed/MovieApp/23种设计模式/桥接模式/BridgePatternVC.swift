//
//  BridgePatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/8.
//

import UIKit

class BridgePatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let redCircle = Circle(with: 100, with: 100, with: 10, with: RedCircle())
        let greenCircle = Circle(with: 100, with: 100, with: 10, with: GreenCircle())
        redCircle.draw()
        greenCircle.draw()
    }

}
