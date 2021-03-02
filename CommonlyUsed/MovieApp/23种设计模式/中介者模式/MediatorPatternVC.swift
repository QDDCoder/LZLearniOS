//
//  MediatorPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/2.
//

import UIKit

class MediatorPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tom = User(with: "Tom")
        let john = User(with: "John")
            
        tom.sendMesage(message: "Hi!,John！")
        john.sendMesage(message: "Hello!,Tom")

    }    
}
