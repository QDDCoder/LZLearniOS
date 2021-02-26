//
//  Computer.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/2/26.
//

import UIKit

/// 协议抽象类
protocol Computer{
    func getRAM() -> String
    func getHDD() -> String
    func getCPU() -> String
}

/// 协议扩展 增加父类的实现方法
extension Computer{
    func toString() -> String {
        return "RAM= "+getRAM()+", HDD="+getHDD()+", CPU="+getCPU()
    }
}

/// 仅仅只是为了 减少代码 编写了中间件
class ComputerCenter: NSObject,Computer {
    /// 内聚的参数
    private var ram:String=""
    private var hdd:String=""
    private var cpu:String=""
    init(withRam ram:String,withHdd hdd:String,withCpu cpu:String) {
        super.init()
        self.ram=ram
        self.hdd=hdd
        self.cpu=cpu
    }
    
    func getRAM() -> String {
        return self.ram
    }
    
    func getHDD() -> String {
        return self.hdd
    }
    
    func getCPU() -> String {
        return self.cpu
    }
}

/// 子类
class PC:ComputerCenter {
    
}

/// 子类
class Server:ComputerCenter {

}


class ComputerFactory: NSObject {
    override init() {
        super.init()
    }
    
    /// 传入类型和初始化参数构建不同的子类
    /// - Parameters:
    ///   - type: 类型
    ///   - ram: 参数ram
    ///   - hdd: 参数hdd
    ///   - cpu: 参数cpu
    /// - Returns: 抽象的父类
    static func getComputer(withType type:String,withRam ram:String,withHdd hdd:String,withCpu cpu:String) -> Computer {
        if type == "PC" {
            return PC(withRam: ram, withHdd: hdd, withCpu: cpu)
        }else{
            return Server(withRam: ram, withHdd: hdd, withCpu: cpu)
        }
    }
}
