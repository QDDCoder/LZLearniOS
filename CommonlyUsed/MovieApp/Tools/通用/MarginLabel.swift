//
//  UILabelPadding.swift
//  sdxf
//
//  Created by 湛亚磊 on 2019/8/15.
//  Copyright © 2019 湛亚磊. All rights reserved.
//

import UIKit

class MarginLabel: UILabel {
    
    var contentInset: UIEdgeInsets = .zero
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect: CGRect = super.textRect(forBounds: bounds.inset(by: contentInset), limitedToNumberOfLines: numberOfLines)
        //根据edgeInsets，修改绘制文字的bounds
        rect.origin.x -= contentInset.left;
        rect.origin.y -= contentInset.top;
        rect.size.width += contentInset.left + contentInset.right;
        rect.size.height += contentInset.top + contentInset.bottom;
        return rect
    }
    
    override func drawText(in rect: CGRect) {
        
        super.drawText(in: rect.inset(by: contentInset))
    }
}
