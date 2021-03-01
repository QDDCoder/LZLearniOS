//
//  TemplateModel.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/1.
//

import UIKit
/**
 模板模式（Template Pattern）中，一个抽象类公开定义了执行它的方法的方式/模板。它的子类可以按需要重写方法实现，但调用将以抽象类中定义的方式进行。这种类型的设计模式属于行为型模式。
 
 定义一个操作中的算法的骨架，而将一些步骤延迟到子类中。模板方法使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。

 解决:一些方法通用，却在每一个子类都重新写了这一方法。
 如何解决：将这些通用算法抽象出来。
 关键代码：在抽象类实现，其他步骤在子类实现。
 */


//创建一个抽象类，它的模板方法被设置为 final。
class Game:NSObject{
    
    override init() {
        super.init()
    }
    
    // 必须实现
    func initialize(){
        fatalError("Must Override")
    }
    func startPlay(){
        fatalError("Must Override")
    }
    func endPlay(){
        fatalError("Must Override")
    }
    
    final func play()  {
        //初始化游戏
        initialize()
 
        //开始游戏
        startPlay()
 
        //结束游戏
        endPlay()
    }
}


//子类
class Cricket: Game {
    
    override func endPlay() {
        print("Cricket Game 结束!")
    }
    
    override func initialize() {
        print("Cricket Game初始化")
    }
    
    override func startPlay() {
        print("Cricket Game开始")
    }
}

//子类
class Football: Game {
    override func endPlay() {
        print("Football Game 结束!")
    }
    
    override func initialize() {
        print("Football Game初始化")
    }
    
    override func startPlay() {
        print("Football Game开始")
    }
}
