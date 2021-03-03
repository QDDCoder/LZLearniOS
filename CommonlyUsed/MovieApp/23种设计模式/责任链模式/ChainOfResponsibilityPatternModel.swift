//
//  ChainOfResponsibilityPatternModel.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/3.
//

/**
 责任链模式
 
 解释地址:https://www.runoob.com/design-pattern/chain-of-responsibility-pattern.html
 
 顾名思义，责任链模式（Chain of Responsibility Pattern）为请求创建了一个接收者对象的链。这种模式给予请求的类型，对请求的发送者和接收者进行解耦。这种类型的设计模式属于行为型模式。

 在这种模式中，通常每个接收者都包含对另一个接收者的引用。如果一个对象不能处理该请求，那么它会把相同的请求传给下一个接收者，依此类推。
 
 
 
 意图：避免请求发送者与接收者耦合在一起，让多个对象都有可能接收请求，将这些对象连接成一条链，并且沿着这条链传递请求，直到有对象处理它为止
 
 主要解决：职责链上的处理者负责处理请求，客户只需要将请求发送到职责链上即可，无须关心请求的处理细节和请求的传递，所以职责链将请求的发送者和请求的处理者解耦了。
 
 何时使用：在处理消息的时候以过滤很多道。
 
 如何解决：拦截的类都实现统一接口。
 
 关键代码：Handler 里面聚合它自己，在 HandlerRequest 里判断是否合适，如果没达到条件则向下传递，向谁传递之前 set 进去。
 
 优点： 1、降低耦合度。它将请求的发送者和接收者解耦。 2、简化了对象。使得对象不需要知道链的结构。 3、增强给对象指派职责的灵活性。通过改变链内的成员或者调动它们的次序，允许动态地新增或者删除责任。 4、增加新的请求处理类很方便。

 缺点： 1、不能保证请求一定被接收。 2、系统性能将受到一定影响，而且在进行代码调试时不太方便，可能会造成循环调用。 3、可能不容易观察运行时的特征，有碍于除错。

 使用场景： 1、有多个对象可以处理同一个请求，具体哪个对象处理该请求由运行时刻自动确定。 2、在不明确指定接收者的情况下，向多个对象中的一个提交一个请求。 3、可动态指定一组对象处理请求。

 注意事项：在 JAVA WEB 中遇到很多应用。
 
 */

import UIKit

//1.创建抽象的记录器类。

enum LOGERLEVEL:Int {
    case INFO=1
    case DEBUG=2
    case ERROR=3
}

protocol AbstractLogger {
    var level:LOGERLEVEL{get }
    
    var nextLogger:AbstractLogger?{get set}
    
    func write(with message:String)
    
}
extension AbstractLogger{
    mutating func setNextLogger(with nextLogger:AbstractLogger?)  {
        self.nextLogger = nextLogger
    }
    
    func logMessage(with level:LOGERLEVEL,with message:String)  {
        if  self.level.rawValue<=level.rawValue{
            write(with: message)
        }
        if nextLogger != nil {
            nextLogger?.logMessage(with: level, with: message)
        }
    }
}

//2.创建扩展了该记录器类的实体类。

class ConsoleLogger:NSObject,AbstractLogger {
    var level: LOGERLEVEL = .INFO
    
    var nextLogger: AbstractLogger?
    
    init(with level:LOGERLEVEL) {
        self.level = level
    }
    
    
    func write(with message: String) {
        print("Standard Console::Logger: \(message)")
    }
}

class ErrorLogger:NSObject,AbstractLogger {
    internal var level: LOGERLEVEL
    
    var nextLogger: AbstractLogger?
    
    init(with level:LOGERLEVEL) {
        self.level = level
    }
    
    
    func write(with message: String) {
        print("Error Console::Logger: \(message)")
    }
}

class DebugLogger:NSObject,AbstractLogger {
    var level: LOGERLEVEL
    
    var nextLogger: AbstractLogger?
    
    init(with level:LOGERLEVEL) {
        self.level = level
    }
    
    func write(with message: String) {
        print("Debug::Logger: \(message)")
    }
}

//3.创建不同类型的记录器。赋予它们不同的错误级别，并在每个记录器中设置下一个记录器。每个记录器中的下一个记录器代表的是链的一部分。
