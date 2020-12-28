//
//  UIView+Extension.swift
//  sdxf
//
//  Created by 湛亚磊 on 2019/7/31.
//  Copyright © 2019 湛亚磊. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
extension UIView{
    ///设置指定边界的线
    func SetBorderWithOrigion(_ top:Bool,left:Bool,bottom:Bool,right:Bool,width:CGFloat,color:UIColor)
    {
        if top
        {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
            layer.backgroundColor = color.cgColor
            self.layer.addSublayer(layer)
        }
        if left
        {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
            layer.backgroundColor = color.cgColor
            self.layer.addSublayer(layer)
        }
        if bottom
        {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: self.frame.size.height - width, width: width, height: width)
            layer.backgroundColor = color.cgColor
            self.layer.addSublayer(layer)
        }
        if right
        {
            let layer = CALayer()
            layer.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
            layer.backgroundColor = color.cgColor
            self.layer.addSublayer(layer)
        }
    }
    
    ///设置指定圆角
    func SetMutiBorderRoundingCorners(byRoundingCorners corners: UIRectCorner,corner:CGFloat)
    {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds,
                                         byRoundingCorners: corners,
                                         cornerRadii: CGSize(width: corner, height: corner))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func addTapForView() ->(Observable<UITapGestureRecognizer>){
        let ges = UITapGestureRecognizer()
        self.addGestureRecognizer(ges)
        return ges.rx.event.throttle(1.5, latest: true, scheduler: MainScheduler.instance)
    }
}
