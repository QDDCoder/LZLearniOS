//
//  AbstractFactoryModel.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/1.
//
/**
 抽象工厂模式（Abstract Factory Pattern）是围绕一个超级工厂创建其他工厂。该超级工厂又称为其他工厂的工厂。这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式。

 在抽象工厂模式中，接口是负责创建一个相关对象的工厂，不需要显式指定它们的类。每个生成的工厂都能按照工厂模式提供对象。
 */

import UIKit
/// 抽象工厂待生产的shape接口
protocol Shape {
    func draw()
}
/// 抽象工厂待生产的Color接口
protocol Color {
    func fill()
}

class Rectangle: Shape {
    func draw() {
        print("开始Rectangle的绘画")
    }
}

class Square: NSObject, Shape {
    func draw() {
        print("开始Square的绘画")
    }
}

class Red: Color {
    func fill() {
        print("开始Red的fill")
    }
}

class Yellow: Color {
    func fill() {
        print("开始Yellow的fill")
    }
}



/// 抽象工厂类
protocol AbstractFactoryModel {
    func getColor(withColor color:String) -> Color?
    func getShape(withShape shape:String) -> Shape?
}


/// Shape的工厂
class ShapeFactory: AbstractFactoryModel {
    func getColor(withColor color: String) -> Color? {
        return nil
    }
    
    func getShape(withShape shape: String) -> Shape? {
        if shape == "Rectangle"{
            return Rectangle()
        }else if shape == "Square"{
            return Square()
        }
        return nil
    }
}

/// Color的工厂
class ColorFactory: AbstractFactoryModel {
    func getColor(withColor color: String) -> Color? {
        if color == "Red"{
            return Red()
        }else if color == "Yellow"{
            return Yellow()
        }
        return nil
    }
    
    func getShape(withShape shape: String) -> Shape? {
        return nil
    }
}


/// 工厂生产类 通过颜色或者形状获取工厂
class FactoryProducer: NSObject {
    /// 单例
    static func getFactory(withChoice choice:String) -> AbstractFactoryModel? {
        if choice == "Shape" {
            return ShapeFactory()
        }else if choice == "Color"{
            return ColorFactory()
        }
        return nil
    }
}
