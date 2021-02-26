//
//  FactoryVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/2/26.
//

import UIKit

class FactoryVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleInfo = "工厂设计模式"
        
        let pc:Computer = ComputerFactory.getComputer(withType: "PC", withRam: "2GB", withHdd: "500GB", withCpu: "2.4GHz")
        
        let server:Computer = ComputerFactory.getComputer(withType: "Server", withRam: "16GB", withHdd: "1TB", withCpu: "2.9GHz")
        
        print("工厂模式PC 配置: \(pc.toString())")
        print("工厂模式Server 配置: \(server.toString())")

    }
}
