//
//  ViewModelType.swift
//  sdxf
//
//  Created by 湛亚磊 on 2020/1/13.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
protocol ViewModelOrderType {
    var input: Input!{get}
    var output: Output!{get}
    associatedtype Input
    associatedtype Output
}

