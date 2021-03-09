//
//  Int+Extension.swift
//  QKYC
//
//  Created by zhan on 2019/2/25.
//  Copyright © 2019 zhan. All rights reserved.
//

import UIKit

extension Int{
    func toTime()  -> (day:Int,hour:Int,min:Int,sec:Int){
        let tempHour = self/3600 ///多少小时
        let day = tempHour/24
        let hour=tempHour-day*24
        let min = self%3600/60
        let sec = self % 3600 % 60
        return (day,hour,min,sec)
    }
}
extension Int {
    /*这是一个内置函数
     lower : 内置为 0，可根据自己要获取的随机数进行修改。
     upper : 内置为 UInt32.max 的最大值，这里防止转化越界，造成的崩溃。
     返回的结果： [lower,upper) 之间的半开半闭区间的数。
     */
    public static func randomIntNumber(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
    }
    /**
     生成某个区间的随机数
     */
    public static func randomIntNumber(range: Range<Int>) -> Int {
        return randomIntNumber(lower: range.lowerBound, upper: range.upperBound)
    }
}
