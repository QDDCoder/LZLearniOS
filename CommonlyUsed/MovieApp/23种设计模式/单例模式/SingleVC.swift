//
//  SingleVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/2/26.
//

import UIKit

class SingleVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        titleInfo = "单例设计模式"
        
        let sm = SingleModel.sharedInstance
        sm.setTestNumber(number: 1)
        print("第一个number: \(sm.getTestNumber())")
        
        let sm1 = SingleModel.sharedInstance
        print("第二个number: \(sm1.getTestNumber())")
    }
}
