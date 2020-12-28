//
//  UILable+Extension.swift
//  QKYC
//
//  Created by zhan on 2019/2/19.
//  Copyright © 2019 zhan. All rights reserved.
//

import UIKit

extension UILabel{
   
    
    func setLabel(withText text:String, withFont font:UIFont, withTextColor textColor:UIColor, withAlignment alignment:NSTextAlignment) {
        self.text = text 
        self.font = font
        self.textColor = textColor
        self.backgroundColor = UIColor.clear
        self.textAlignment = alignment
    }
    //带圆角
    func setCornerLabel(withText text:String, withFont font:UIFont, withTextColor textColor:UIColor, withBGColor bgColor:UIColor, withAlignment alignment:NSTextAlignment, withCornerRadius cornerRadius:CGFloat, withBorderWidth borderWidth:CGFloat,withBorderColor borderColor:UIColor) {
        self.text = text as String
        self.font = font
        self.textColor = textColor
        self.backgroundColor = bgColor
        self.textAlignment = alignment
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    ///添加中间线
    func addMiddleLine(withString string:String,withColor color:UIColor)  {
        let attribtStr = NSAttributedString.init(string: "\(string)", attributes: [ NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.strikethroughStyle: NSNumber.init(value: Int8(NSUnderlineStyle.single.rawValue))])
        self.attributedText=attribtStr
    }
    
    ///设置行间距
    func setLineSpace(withText text:String,withSpace space:CGFloat)  {
        let attributedString = NSMutableAttributedString(string: text)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = space // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        // *** Set Attributed String to your label ***
        self.attributedText = attributedString;
    }
}
