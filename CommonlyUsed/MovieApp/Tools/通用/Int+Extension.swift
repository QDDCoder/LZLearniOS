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
