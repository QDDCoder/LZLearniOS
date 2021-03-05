//
//  IteratorPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/5.
//

import UIKit

class IteratorPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let namesRepository = NameRepository()
        let iterator = namesRepository.getIterator()
        while let iteror = iterator.next() {
            print(iteror)
        }
        
    }

}
