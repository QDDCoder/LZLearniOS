//
//  HomeApi.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import Moya
enum HomeApi:BaseApi{
    ///获取首页数据
    case getHomeTopInfo(_ params:[String:Any])
    
    ///获取首页数据
    case getHomeListInfo(_ params:[String:Any])
    
    ///搜索
    case getSearchListInfo(_ params:[String:Any])
    
}

extension HomeApi{
    var path: String{
        switch self {
        case .getHomeTopInfo(_):
            return homeTopCategoryUrl
        case .getHomeListInfo(_):
            return homeVideoListUrl
        case .getSearchListInfo(_):
            return homeSearchListUrl
        }
    }
    var method: Moya.Method{
        switch self {
        case .getHomeTopInfo(_):
            return .get
        default:
            return .post
        }
    }
    var cacheType: ApiCacheType{
        return .none
    }
    var task: Task{
        switch self {
        case .getHomeTopInfo(let params):
            return .requestParameters(parameters: ["":""], encoding: URLEncoding.default)
        case .getHomeListInfo(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getSearchListInfo(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    var headers: [String : String]?{
        let headers = ["Content-type":"application/x-www-form-urlencoded"]
        return headers
    }
    var sampleData: Data{
        return Data()
    }
}

