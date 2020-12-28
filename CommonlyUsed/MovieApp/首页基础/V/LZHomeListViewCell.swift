//
//  LZHomeListViewCell.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/24.
//

import UIKit

class LZHomeListViewCell: UICollectionViewCell {
    
    private lazy var bgView = UIView().then {
        $0.backgroundColor = .white
        $0.isUserInteractionEnabled=true
        $0.layer.cornerRadius=6*PionWidth
        $0.layer.masksToBounds=true
    }
    
    
    ///
    private lazy var videoImageView = UIImageView().then {
        $0.layer.cornerRadius=6*PionWidth
        $0.layer.masksToBounds=true
        bgView.addSubview($0)
    }

    /// 商品名字
    private lazy var videoNameLabel = UILabel().then {
        $0.textColor = UIColor.RGB(r: 20, g: 20, b: 20)
        $0.font=UIFont.systemFont(ofSize: 16)
        $0.numberOfLines=2
        bgView.addSubview($0)
    }

    /// 商品价格
    private lazy var videoViewCountLabel = UILabel().then {
        $0.textColor = UIColor.RGB(r: 100, g: 100, b: 100)
        $0.font=UIFont.systemFont(ofSize: 12)
        $0.numberOfLines=1
        bgView.addSubview($0)
    }
    
    func updateInfo(withIcons videoURL:String,withNames name:String,withViewCount vCount:String)  {
        videoImageView.kf.setImage(with: URL(string: videoURL))
        videoNameLabel.text=name
        videoViewCountLabel.text="观看数量:\(vCount)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10*PionHeight)
            make.centerX.equalToSuperview()
        }
        
        
        videoImageView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(100*PionHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        videoNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(videoImageView.snp.bottom).offset(6*PionHeight)
            make.left.equalToSuperview().offset(8*PionWidth)
            make.right.equalToSuperview().offset(-8*PionWidth)
            make.height.equalTo(videoNameLabel)
        }
        videoViewCountLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12*PionHeight)
            make.left.equalToSuperview().offset(8*PionWidth)
            make.height.equalTo(videoViewCountLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
