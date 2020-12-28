//
//  SearchView.swift
//  searchHistory
//
//  Created by zhan on 2018/4/9.
//  Copyright © 2018年 zhan. All rights reserved.
//

import UIKit

class SearchView: UIView {
    //标题
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.RGB(r: 163, g: 162, b: 159)
        return titleLabel
    }()
    
    ///标题头
    var titleInfo:String = ""{
        didSet{
            titleLabel.text = titleInfo
        }
    }
    
//    private let clearBtn=UIButton()
    
    //按钮的回调block
    private var btnCallBackBlock: ((_ btn: UIButton) -> ())?
    //SearchView的总高度
    var searchViewHeight: CGFloat = 0
    
    ///数据信息
    var titleLabelInfos:[String] = [String](){
        didSet{
            subviews.forEach { (view) in
                if view.viewWithTag(-1) != nil{
                    view.removeFromSuperview()
                }
            }
            //上一个按钮的maxX加上间距
            var lastX: CGFloat = 0
            //上一个按钮的y值
            var lastY: CGFloat = 36
            //按钮文字的宽度
            var btnW: CGFloat = 0
            //按钮的高度
            let btnH: CGFloat = 30
            //文字与按钮两边的距离之和
            let addW: CGFloat = 30
            //横向间距
            let marginX: CGFloat = 10
            //纵向间距
            let marginY: CGFloat = 20
            
            titleLabelInfos.forEach { (value) in
                let btn = UIButton(type: .custom)
                ///移除视图的时候使用
                btn.tag = -1
                btn.setTitle(value, for: .normal)
                btn.setTitleColor(UIColor.RGB(r: 101, g: 102, b: 104), for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                btn.titleLabel?.sizeToFit()
                btn.backgroundColor = UIColor.RGB(r: 250, g: 250, b: 250)
                btn.layer.cornerRadius = 15
                btn.layer.masksToBounds = true
                btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
                //按钮的总宽度
                btnW = (btn.titleLabel?.bounds.width)! + addW
                //在给按钮的frame赋值之前先判断本行余下的宽度是否大于将要布局的按钮的宽度,如果大于则x值为上一个按钮的宽度加上横向间距,y值与上一个按钮相同,如果小于则x值为0,y值为上一个按钮的y值加上按钮的高度和纵向间距
                if frame.width - lastX-20 > btnW {
                    btn.frame = CGRect(x: lastX, y: lastY, width: btnW, height: btnH)
                } else {
                    btn.frame = CGRect(x: 0, y: lastY + marginY + btnH, width: btnW, height: btnH)
                }
                lastX = btn.frame.maxX + marginX
                lastY = btn.frame.origin.y
                searchViewHeight = btn.frame.maxY+20
                addSubview(btn)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, btnCallBackBlock: @escaping ((_ sender: UIButton) -> ())) {
        self.init(frame: frame)

        self.btnCallBackBlock = btnCallBackBlock
    }
    
    @objc private func btnClick(sender: UIButton) {
        btnCallBackBlock!(sender)
    }

}
