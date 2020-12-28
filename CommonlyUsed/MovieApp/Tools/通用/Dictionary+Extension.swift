//
//  Dictionary+Extension.swift
//  QKYC
//
//  Created by 七颗牙 on 2019/3/4.
//  Copyright © 2019 zhan. All rights reserved.
//

import UIKit

extension Dictionary{
    func getJSONStringFromDictionary() -> String {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: self, options: []) as NSData
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
    func jsonToData() -> Data? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("is not a valid json object")
            return nil
        }
            
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        //Data转换成String打印输出
        let str = String(data:data!, encoding: String.Encoding.utf8)
        //输出json字符串
        print("Json Str:\(str!)")
        return data
    }
}
