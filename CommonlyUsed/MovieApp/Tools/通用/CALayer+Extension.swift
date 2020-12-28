//
//  CALayer+Extension.swift
//  sdxf
//
//  Created by 湛亚磊 on 2019/7/16.
//  Copyright © 2019 湛亚磊. All rights reserved.
//

import UIKit

extension CALayer{
    func addShadow(shadowColor:UIColor,shadowOpacity:CGFloat,shadowRadius:CGFloat,shadowOffset:CGSize){
        self.shadowColor = shadowColor.cgColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = Float(shadowOpacity)
    }
}
