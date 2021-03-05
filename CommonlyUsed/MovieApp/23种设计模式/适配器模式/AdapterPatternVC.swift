//
//  StrategyPatternVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/3/5.
//

import UIKit

class AdapterPatternVC: LZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let audioPlayer = AudioPlayer()
        audioPlayer.play(with: "mp3", with: "beyond the horizon.mp3")
        audioPlayer.play(with: "mp4", with: "alone.mp4")
        audioPlayer.play(with: "vlc", with: "far far away.vlc")
        audioPlayer.play(with: "avi", with: "mind me.avi")
    }

}
