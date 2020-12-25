//
//  Data+Extension.swift
//  xfsdny
//
//  Created by 湛亚磊 on 2020/8/6.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit

extension Data{
    func dataToDictionary() ->Dictionary<String, Any>?{
        do{
            let json = try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            return dic
        }catch _ {
            print("失败")
            return nil
        }
    }
}


