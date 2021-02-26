//
//  SingleModel.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/2/26.
//

import UIKit

/// 单例模式
class SingleModel: NSObject {
    
    /// 测试数字
    private var testNumber:Int = 0
    
    static let sharedInstance:SingleModel=SingleModel()
    override init() {
        super.init()
    }
    
    /// 设置参数
    /// - Parameter number: 数字参数
    func setTestNumber(number:Int)  {
        testNumber = number
    }
    
    /// 获取数字参数
    /// - Returns: 返回数字参数
    func getTestNumber() -> Int {
        return testNumber
    }
}
