//
//  DateTools.swift
//  Feicui
//
//  Created by people on 2018/7/7.
//  Copyright © 2018年 zhan. All rights reserved.
//

import UIKit

extension Date {
    ///获取当前时间
    func get_CurrentDate() -> Date {
        // 得到当前时间（世界标准时间 UTC/GMT）
        var date = Date()
        // 设置系统时区为本地时区
        let zone = TimeZone.current
        // 计算本地时区与 GMT 时区的时间差
        let second:Int = zone.secondsFromGMT()
        // 在 GMT 时间基础上追加时间差值，得到本地时间
        date = date.addingTimeInterval(TimeInterval(second))
        //        print("本地时间\(date)")
        return date
    }
    ///获取 当前的天的日期
    func toDateString() -> String {
        let dateFormatter = DateFormatter()
        // setup formate string for the date formatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone=TimeZone(abbreviation: "Asia/Shanghai")
        // format the current date and time by the date formatter
        let dateStr = dateFormatter.string(from: Date())
        return dateStr
    }
    ///当前Date->String
    func date_String(withFormate formate:String="yyy-MM-dd HH:mm:ss") -> String {
        let nowDate = self
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = formate
        let date : String = formatter.string(from: nowDate)
        return date
    }
    // 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
}
