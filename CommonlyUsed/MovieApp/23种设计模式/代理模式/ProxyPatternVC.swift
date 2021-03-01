//
//  ProxyPatternVCViewController.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/1.
//

import UIKit

class ProxyPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = ProxyImage(withFileName: "test_10mb.jpg")
        //图像从磁盘加载
        image.display()
        print("")
        //图像不需要从磁盘加载
        image.display()
        
    }
}
