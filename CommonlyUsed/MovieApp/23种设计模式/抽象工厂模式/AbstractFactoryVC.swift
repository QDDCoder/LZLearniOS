//
//  AbstractFactoryModel.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/1.
//


import UIKit

/// 抽象工厂测试类
class AbstractFactoryVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 获取形状工厂
        let shapeFactory = FactoryProducer.getFactory(withChoice: "Shape")
        //获取形状为Square的对象
        if let shape1 = shapeFactory?.getShape(withShape: "Square") {
            shape1.draw()
        }
        
        //获取形状为Rectangle
        if let shape2 = shapeFactory?.getShape(withShape: "Rectangle") {
            shape2.draw()
        }
        
        //获取颜色工厂
        let colorFactory = FactoryProducer.getFactory(withChoice: "Color")
        //获取red对象
        if let color1 = colorFactory?.getColor(withColor: "Red") {
            color1.fill()
        }
        //获取yellow对象
        if let color2 = colorFactory?.getColor(withColor: "Yellow") {
            color2.fill()
        }
    }

}
