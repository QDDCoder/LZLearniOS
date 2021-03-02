//
//  PrototypePatternVCViewController.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/2.
//

import UIKit

class PrototypePatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        simapleClone()
        print("---------------")
        cloneManager()
        
    }
    
    /// 简单拷贝
    private func simapleClone()  {
        let author = Person(name: "啊哈哈", height: 173, pet: Pet(name: "球球", weight: 2.0))
        var persons:[Person] = [Person]()
        for _ in 0...9 {
            persons.append(author.clone() as! Person)
        }
        persons.forEach { (p) in
            print("--->>\(p.name)-->\(p.pet?.name)")
        }
    }
    
    //登记拷贝
    func cloneManager() {
        let author = Person(name: "啊哈哈", height: 173, pet: Pet(name: "球球", weight: 2.0))
        let clone = author.clone()
        CloneManager.sharedManager.store(prototype: clone as! Cloning, for: "CloneInstance")
        
        let storeClone = CloneManager.sharedManager.prototype(for: "CloneInstance")
        
        if clone.isEqual(storeClone) {
            print("获取成功")
        }
        if !clone.isEqual(author){
            print("你创建了一个拷贝 author")
        }
    }
}
