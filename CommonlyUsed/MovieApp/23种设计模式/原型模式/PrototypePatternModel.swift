//
//  PrototypePatternModel.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/2.
//
/**
 原型模式
 
 解释地址:https://www.runoob.com/design-pattern/prototype-pattern.html
 
 原型模式（Prototype Pattern）是用于创建重复的对象，同时又能保证性能。这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式。

 这种模式是实现了一个原型接口，该接口用于创建当前对象的克隆。当直接创建对象的代价比较大时，则采用这种模式。例如，一个对象需要在一个高代价的数据库操作之后被创建。我们可以缓存该对象，在下一个请求时返回它的克隆，在需要的时候更新数据库，以此来减少数据库调用。
 
 
 
 意图：用原型实例指定创建对象的种类，并且通过拷贝这些原型创建新的对象。
 
 主要解决：在运行期建立和删除原型。
 
 何时使用： 1、当一个系统应该独立于它的产品创建，构成和表示时。 2、当要实例化的类是在运行时刻指定时，例如，通过动态装载。 3、为了避免创建一个与产品类层次平行的工厂类层次时。 4、当一个类的实例只能有几个不同状态组合中的一种时。建立相应数目的原型并克隆它们可能比每次用合适的状态手工实例化该类更方便一些。
 
 如何解决：利用已有的一个原型对象，快速地生成和原型对象一样的实例。
 
 优点： 1、性能提高。 2、逃避构造函数的约束。

 缺点： 1、配备克隆方法需要对类的功能进行通盘考虑，这对于全新的类不是很难，但对于已有的类不一定很容易，特别当一个类引用不支持串行化的间接对象，或者引用含有循环结构的时候。 2、必须实现 Cloneable 接口。
 

 */
import UIKit

protocol Cloning {
    func clone() -> AnyObject
}

class Pet: NSObject {
    var name :String?
    var weight:Float?
    init(name:String,weight:Float) {
        super.init()
        self.name   = name
        self.weight = weight
    }
}

extension Pet:Cloning {
    func clone() -> AnyObject {
        return Pet(name: name!, weight: weight!)
    }
}

class Person: NSObject {
    var pet:Pet?
    var name:String?
    var height:Float?
    init(name:String,height:Float,pet:Pet) {
        super.init()
        self.name   = name
        self.height = height
        self.pet    = pet
    }
}

extension Person:Cloning{
    func clone() -> AnyObject {
        return Person(name: name!, height: height!, pet: pet?.clone() as! Pet)
    }
}


//登记拷贝
/**
 在简单拷贝基础上 增加了 clone管理
 */
class CloneManager: NSObject {
    static let sharedManager=CloneManager()
    private var mapper:[String:Cloning] = [String:Cloning]()
    private override init() {
        super.init()
    }
    
    //增加
    func store(prototype:Cloning,for identifier:String)  {
        mapper[identifier]=prototype
    }
    
    //获取
    func prototype(for identifier:String) -> Cloning? {
        return mapper[identifier]
    }
    
    //删除
    func remove(with identifier:String)  {
        mapper[identifier]=nil
    }
    
}
