//
//  FacadePatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/8.
//

import UIKit

class FacadePatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let shapeMaker = ShapeMaker()
        shapeMaker.drawCircle()
        shapeMaker.drawRectangle()
        shapeMaker.drawSquare()
    }
}
