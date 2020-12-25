//
//  NetWorking.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//
import Moya
final class NetWorking<Target: TargetType>: MoyaProvider<Target> {
    init(plugins: [PluginType] = []) {
        //设置请求超时时间
        let requestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<Target>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 6
                done(.success(request))
            } catch {
                return
            }
        }
        super.init( requestClosure: requestTimeoutClosure, plugins: plugins)
    }
}
