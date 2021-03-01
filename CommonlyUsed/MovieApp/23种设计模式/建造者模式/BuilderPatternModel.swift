//
//  BuilderPatternModel.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/1.
//
//建造者模式
//解释地址 https://www.runoob.com/design-pattern/builder-pattern.html
/**
 建造者模式（Builder Pattern）使用多个简单的对象一步一步构建成一个复杂的对象。这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式。
 
 一个 Builder 类会一步一步构造最终的对象。该 Builder 类是独立于其他对象的。
 
 意图：将一个复杂的构建与其表示相分离，使得同样的构建过程可以创建不同的表示。
 
 主要解决：主要解决在软件系统中，有时候面临着"一个复杂对象"的创建工作，其通常由各个部分的子对象用一定的算法构成；由于需求的变化，这个复杂对象的各个部分经常面临着剧烈的变化，但是将它们组合在一起的算法却相对稳定。
 
 何时使用：一些基本部件不会变，而其组合经常变化的时候。
 
 如何解决：将变与不变分离开。
 
 关键代码：建造者：创建和提供实例，导演：管理建造出来的实例的依赖关系。
 
 优点： 1、建造者独立，易扩展。 2、便于控制细节风险。

 缺点： 1、产品必须有共同点，范围有限制。 2、如内部变化复杂，会有很多的建造类。
 
 使用场景： 1、需要生成的对象具有复杂的内部结构。 2、需要生成的对象内部属性本身相互依赖。

 注意事项：与工厂模式的区别是：建造者模式更加关注与零件装配的顺序。
 */


import UIKit

///1.创建接口
//食物条目
protocol Item{
    func name() -> String
    func packing() -> Packing
    func price() -> Float
}

//包装抽象
protocol Packing {
    func pack() -> String
}


//2.Packing接口实体类,包装
class Wrapper: Packing {
    func pack() -> String {
        return "Wrapper"
    }
}
class Bottle: Packing {
    func pack() -> String {
        return "Bottle"
    }
}

//3.实现 Item 接口的抽象类
//汉堡
protocol Burger:Item {

}
extension Burger{
    func packing() -> Packing {
        return Wrapper()
    }
}

//冷饮
protocol ColdDrink:Item {

}
extension ColdDrink{
    func packing() -> Packing {
        return Bottle()
    }
}

///4.创建扩展了 Burger 和 ColdDrink 的实体类。
class VegBurger:NSObject, Burger {
    func name() -> String {
        return "Veg Burger"
    }
    
    func price() -> Float {
        return 25.0
    }
}

class ChickenBurger: NSObject,Burger {
    func name() -> String {
        return "Chicken Burger"
    }
    
    func price() -> Float {
        return 50.5
    }
}

class Pepsi: ColdDrink {
    func name() -> String {
        return "Pepsi"
    }
    
    func price() -> Float {
        return 35.0
    }
}

class Coke: ColdDrink {
    func name() -> String {
        return "Coke"
    }
    
    func price() -> Float {
        return 30.0
    }
}

//5.创建一个 Meal 类，带有上面定义的 Item 对象。
class Meal: NSObject {
    var items = [Item]()
    func addItem(withItem item:Item)  {
        items.append(item)
    }
    
    func getCost() -> Float {
        var cost:Float = 0.0
        items.forEach { (item) in
            cost+=item.price()
        }
        return cost
    }
    
    func showItems()  {
        items.forEach { (item) in
            print("Item的名字:\(item.name())")
            print(",包装:\(item.packing().pack())")
            print(",价格:\(item.price())")
        }
    }
}


//6.创建一个 MealBuilder 类，实际的 builder 类负责创建 Meal 对象。
class MealBuilder: NSObject {
    func prepareVegMeal() -> Meal {
        let meal = Meal()
        meal.addItem(withItem: VegBurger())
        meal.addItem(withItem: Coke())
        return meal
    }
    
    func prepareNonVegMeal() -> Meal {
        let meal = Meal()
        meal.addItem(withItem: ChickenBurger())
        meal.addItem(withItem: Pepsi())
        return meal
    }
}
