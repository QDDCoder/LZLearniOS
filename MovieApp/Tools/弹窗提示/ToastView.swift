//
//  ToastView.swift
//  Feicui
//
//  Created by people on 2018/7/10.
//  Copyright © 2018年 zhan. All rights reserved.
//

import UIKit
//弹窗工具
class ToastView : NSObject{
    
    static var instance : ToastView = ToastView()
    
    var windows = UIApplication.shared.windows
    let rv = UIApplication.shared.keyWindow?.subviews.first as UIView?
    
    //显示加载圈圈
    func showLoadingView() {

        let frame = CGRect(x: (ScreenW - 110*PionWidth)/2, y: (ScreenH - 1.5*NAVBAR_HEIGHT - 110*PionWidth)/2, width: 110*PionWidth, height: 110*PionWidth)
        let loadingContainerView = UIView()
        loadingContainerView.layer.cornerRadius = 12
        loadingContainerView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.55)
        
        let indicatorWidthHeight :CGFloat = 72
        let loadingIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        loadingIndicatorView.frame = CGRect(x: frame.width/2 - indicatorWidthHeight/2, y: frame.height/2 - indicatorWidthHeight/2, width: indicatorWidthHeight, height: indicatorWidthHeight)
        
        loadingIndicatorView.startAnimating()
        loadingContainerView.addSubview(loadingIndicatorView)
        
        let window = UIWindow()
        window.backgroundColor = .clear
        window.frame = CGRect(x: 0, y: NAVBAR_HEIGHT, width: ScreenW, height: ScreenH-NAVBAR_HEIGHT)
        loadingContainerView.frame = frame
        
        window.windowLevel = UIWindow.Level.alert
        window.isHidden = false
        window.addSubview(loadingContainerView)
        windows.append(window)
    }
    ///加载框 配合gif
    func loadingGif()  {

        let frame = CGRect(x: (ScreenW - 160*PionWidth)/2, y: (ScreenH - 90*PionHeight)/2, width: 160*PionWidth, height: 90*PionHeight)
        let loadingContainerView = UIView()
        loadingContainerView.layer.cornerRadius = 12
        loadingContainerView.backgroundColor = UIColor.clear
        let gifLoadingView = UIImageView(frame: frame)
        gifLoadingView.image=UIImage.gif(asset: "loading")
        loadingContainerView.addSubview(gifLoadingView)
        
        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        window.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH)
        loadingContainerView.frame = window.frame
        window.windowLevel = UIWindow.Level.alert
        window.center = CGPoint(x: (rv?.center.x)!, y: (rv?.center.y)!)
        window.isHidden = false
        window.addSubview(loadingContainerView)
        windows.append(window)
    }
    
    
    //弹窗图片文字
    func showToast(content:String , imageName:String="对勾", duration:CFTimeInterval=1.4,withFinishBlock block:(()->())?=nil) {
        clear()
        let frame = CGRect(x: 0, y: 0, width: 190*PionWidth, height: 100*PionHeight)
        
        
        let toastContainerView = UIView()
        toastContainerView.layer.cornerRadius = 10
        toastContainerView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.55)
        var iconWidthWidth :CGFloat = 36
        var iconWidthHeight :CGFloat = 23
        if imageName == "对勾"{
            iconWidthWidth=35*PionWidth
            iconWidthHeight=23*PionHeight
        }else if imageName == "叹号"{
            iconWidthWidth=30*PionWidth
            iconWidthHeight=30*PionHeight
        }
        
        var toastIconView:UIImageView!
        if imageName != ""{
            toastIconView = UIImageView(image: UIImage(named: imageName))
            toastIconView.frame =  CGRect(x: (frame.width - iconWidthWidth)/2, y: 20*PionHeight, width: iconWidthWidth, height: iconWidthHeight)
            toastContainerView.addSubview(toastIconView)
        }
        var toastContentView:UILabel!
        if imageName=="" {
            toastContentView = UILabel(frame: CGRect(x: 0, y: frame.origin.y/2, width: frame.width, height: frame.height))
        }else{
            toastContentView = UILabel(frame: CGRect(x: 0, y: iconWidthHeight + 10*PionHeight, width: frame.width, height: frame.height - iconWidthHeight))
        }
        
        
        toastContentView.font = UIFont.systemFont(ofSize: 16)
        toastContentView.textColor = UIColor.white
        toastContentView.text = content
        toastContentView.numberOfLines = 0
        toastContentView.textAlignment = NSTextAlignment.center
        toastContainerView.addSubview(toastContentView)

        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        window.frame = frame
        toastContainerView.frame = frame
        
        window.windowLevel = UIWindow.Level.alert
        window.center = CGPoint(x: (rv?.center.x)!, y: (rv?.center.y)!)
        window.isHidden = false
        window.addSubview(toastContainerView)
        windows.append(window)
        
        toastContainerView.layer.add(AnimationUtil.getToastAnimation(duration: duration), forKey: "animation")
        ///延时移除 动画
        weak var weakSelf=self
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+duration-0.2) {
            block?()
            toastContainerView.layer.removeAllAnimations()
            toastContainerView.backgroundColor=UIColor.clear
            window.backgroundColor=UIColor.clear
            weakSelf?.remoToast(withWindow: window)
        }
    }
    func remoToast(withWindow window:UIWindow)  {
        if let index = windows.index(where: { (item) -> Bool in
            return item == window
        }) {
            // print("find the window and remove it at index \(index)")
            windows.remove(at: index)
        }
    }
 
    //移除当前弹窗
    @objc func removeToast(sender: AnyObject) {
        if let window = sender as? UIWindow {
            if let index = windows.index(where: { (item) -> Bool in
                item.backgroundColor=UIColor.clear
                return item == window
            }) {
                // print("find the window and remove it at index \(index)")
                windows.remove(at: index)
            }
        }else{
            // print("can not find the window")
        }
    }
    
    //清除所有弹窗
    func clear() {
        windows.removeAll(keepingCapacity: false)
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }
}
class AnimationUtil{
    //弹窗动画
    static func getToastAnimation(duration:CFTimeInterval = 1.6) -> CAAnimation{
        // 大小变化动画
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.2, 0.3, 0.9,1]
        scaleAnimation.values = [0.5, 1, 0.9,0.9,0.9]
        scaleAnimation.duration = duration
        scaleAnimation.repeatCount = 0// HUGE
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.fillMode = .forwards
        // 透明度变化动画
        let opacityAnimaton = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimaton.keyTimes = [0, 0.9,1]
        opacityAnimaton.values = [0.5, 1, 1,0]
        opacityAnimaton.duration = duration
        opacityAnimaton.repeatCount = 0// HUGE
        opacityAnimaton.isRemovedOnCompletion = false
        opacityAnimaton.fillMode = .forwards
        // 组动画
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, opacityAnimaton]
        //动画的过渡效果1. kCAMediaTimingFunctionLinear//线性 2. kCAMediaTimingFunctionEaseIn//淡入 3. kCAMediaTimingFunctionEaseOut//淡出4. kCAMediaTimingFunctionEaseInEaseOut//淡入淡出 5. kCAMediaTimingFunctionDefault//默认
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        
        animation.duration = duration
        animation.repeatCount = 0// HUGE
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        return animation
    }
}

