//
//  DecoratorPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/4.
//

import UIKit

class DecoratorPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let circle = CircleMM()
        let redCircle = RedShapeDecorator(with: CircleMM())
        let redRectangle = RedShapeDecorator(with: RectangleMM())
        
        print("Circle with normal border")
        circle.draw()
        
        print("Circle of red border")
        redCircle.draw()
        
        print("Rectangle of red border")
        redRectangle.draw()
        
        
    }
    

}
