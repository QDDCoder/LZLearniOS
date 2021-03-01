//
//  TemplateVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/1.
//

import UIKit

class TemplateVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var game:Game = Cricket()
        game.play()
        
        game = Football()
        game.play()
        
    }

}
