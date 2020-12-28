//
//  URL+Extension.swift
//  xfsdny
//
//  Created by 湛亚磊 on 2020/6/5.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit

extension URL {
    
    /// 从URL中取参数
    public var parametersFromQueryString : [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
        let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
