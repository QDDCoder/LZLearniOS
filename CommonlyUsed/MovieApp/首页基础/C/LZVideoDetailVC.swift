//
//  LZVideoDetailVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/24.
//

import UIKit
class LZVideoDetailVC: LZBaseVC {
    var videoUrl:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenTopBar = false
        setup()
        self.titleInfo = "视频详情"
    }
    
    private func setup() {
        
        let player = QZIJKPlayerViewController()
        player.view.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.width * 9 / 16)
        self.view.addSubview(player.view)
        self.addChild(player)
        
        let playModel_first = QZIJKPlayerPlayModel(title: "Test_1", url: "https://haitang.kankan-kuyunzy.com/20191116/189_886788f2/1000k/hls/index.m3u8", name: "高清")
        player.setPlayData(playModels: [playModel_first])
        player.delegate = self
        player.isHiddenBottomProgressView = true
        
    }
    
}
extension LZVideoDetailVC :QZIJKPlayerDelegate{
    func seek() {
        ToastView.instance.showLoadingView()
    }
    func playing() {
        ToastView.instance.clear()
    }
    
}
