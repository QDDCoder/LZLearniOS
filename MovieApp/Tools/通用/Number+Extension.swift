//
//  Number+Extension.swift
//  Feicui
//
//  Created by people on 2018/4/17.
//  Copyright © 2018年 zhan. All rights reserved.
//

import Foundation
import UIKit
extension Float{
    func FloatToStringCurrent(withCurrent current:String) -> String {
        return String(NSString(format: current as NSString, self))
    }
}

extension String{
    func StringToFloat() ->Float {
        var cgFloat: CGFloat = 0
        if let doubleValue = Double(self)
        {
            cgFloat = CGFloat(doubleValue)
        }
        return Float(cgFloat)
    }
   
    //判断是否是整数
    func isPurnInt() -> Bool {
        let scan: Scanner = Scanner(string: self)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    //判断是否是float
    func isPurnFloat(string: String) -> Bool {
        let scan: Scanner = Scanner(string: self)
        var val:Float = 0
        return scan.scanFloat(&val) && scan.isAtEnd
    }
}
