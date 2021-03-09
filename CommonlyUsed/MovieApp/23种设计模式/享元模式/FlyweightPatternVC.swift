//
//  FlyweightPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/9.
//

import UIKit

class FlyweightPatternVC: LZBaseVC {
    let colors:[String] = ["Red", "Green", "Blue", "White", "Black"]
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0 ..< 20 {
            let circle = ShapeFlyweightFactory.getCircle(with: getRandomColor())
            if let cc:CircleFlyweight = circle as? CircleFlyweight {
                cc.setX(with: getRandomX())
                cc.setY(with: getRandomY())
                cc.setRadius(with: 100)
                cc.draw()
            }
        }
    }
    
    func getRandomColor() -> String {
        return colors[Int.randomIntNumber(lower: 0, upper: colors.count)]
    }
    
    func getRandomX() -> Int {
        return Int.randomIntNumber(lower: 0, upper: 100)
    }
    
    func getRandomY() -> Int {
        return Int.randomIntNumber(lower: 0, upper: 100)
    }
    
}

