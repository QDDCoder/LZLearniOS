//
//  UIButton+Extension.swift
//  QKYC
//
//  Created by zhan on 2019/2/18.
//  Copyright © 2019 zhan. All rights reserved.
//

import UIKit

extension UIButton{
    func roundedRect(byRoundingCorners corners: UIRectCorner, cornerRadii: CGSize) -> UIButton {
        let bezierPath = UIBezierPath(roundedRect: self.bounds,
                                      byRoundingCorners: corners, //哪个角
            cornerRadii: cornerRadii) //圆角半径
        let maskLayer = CAShapeLayer()
        maskLayer.path = bezierPath.cgPath
        return self
    }
    /** 部分圆角
     * - corners: 需要实现为圆角的角，可传入多个
     * - radii: 圆角半径
     */
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func setButton(withText text:NSString, withFont font:UIFont, withTextColor textColor:UIColor, withBGColor bgColor:UIColor, withAlignment alignment:NSTextAlignment) {
        self.setTitle(text as String, for: .normal)
        self.titleLabel!.font = font
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = bgColor
        self.titleLabel!.textAlignment = alignment
    }

    func setCornerButton(withText text:NSString, withFont font:UIFont, withTextColor textColor:UIColor, withBGColor bgColor:UIColor, withAlignment alignment:NSTextAlignment, withCornerRadius cornerRadius:CGFloat, withBorderWidth borderWidth:CGFloat,withBorderColor borderColor:UIColor) {
        self.setTitle(text as String, for: .normal)
        self.titleLabel!.font = font
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = bgColor
        self.titleLabel!.textAlignment = alignment
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}

enum HWButtonMode {
    case Top
    case Bottom
    case Left
    case Right
}
import UIKit

extension UIButton {
    
    /// 快速调整图片与文字位置
    ///
    /// - Parameters:
    ///   - buttonMode: 图片所在位置
    ///   - spacing: 文字和图片之间的间距
    func lz_locationAdjust(buttonMode: HWButtonMode,
                           spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = titleLabel?.text?.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: titleFont!]) ?? CGSize.zero
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        switch (buttonMode){
        case .Top:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
        case .Bottom:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
        case .Left:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .Right:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        }
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
}

//防止多次点击
// MARK: - 快速设置按钮 并监听点击事件
typealias  buttonClick = (()->()) // 定义数据类型(其实就是设置别名)
extension UIButton {
    // 改进写法【推荐】
    private struct HWRuntimeKey {
        static let actionBlock = UnsafeRawPointer.init(bitPattern: "actionBlock".hashValue)
        static let delay = UnsafeRawPointer.init(bitPattern: "delay".hashValue)
        /// ...其他Key声明
    }
    /// 运行时关联
    private var actionBlock: buttonClick? {
        set {
            objc_setAssociatedObject(self, UIButton.HWRuntimeKey.actionBlock!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UIButton.HWRuntimeKey.actionBlock!) as? buttonClick
        }
    }
    private var delay: TimeInterval {
        set {
            objc_setAssociatedObject(self, UIButton.HWRuntimeKey.delay!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UIButton.HWRuntimeKey.delay!) as? TimeInterval ?? 0
        }
    }
    /// 点击回调
    @objc private func tapped(button:UIButton) {
        actionBlock?()
        isEnabled = false
        // 4.GCD 主线程/子线程
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in // 延迟调用方法
            DispatchQueue.main.async { // 不知道有没有用反正写上就对了
                print("恢复时间\(Date())")
                self?.isEnabled = true
            }
        }
    }
    /// 添加点击事件
    func addAction(_ delay: TimeInterval = 0, action:@escaping buttonClick) {
        addTarget(self, action:#selector(tapped(button:)) , for:.touchUpInside)
        self.delay = delay
        actionBlock = action
    }
}

