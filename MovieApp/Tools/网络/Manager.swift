//
//  Manager.swift
//  LZCache
//
//  Created by 湛亚磊 on 2020/3/14.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import Reachability

class LZRequestManager: NSObject {
    static let homeApi = NetWorking<HomeApi>()
}
///响应的model
enum ResponseType:Int {
    case nomal=1
    case netNoData=2
}

extension MoyaProviderType{
    func getResponse(target: Target,with type:ResponseType = .nomal) -> Observable<AnyObject?> {
        let reachability = try! Reachability()
        switch reachability.connection {
            case .cellular,.wifi:
                return Observable.create { [weak self] observer in
                     print("请求的内容g~~~\(target.parameters) ---- >>> \(target.url)")
                    
                     let cancellableToken = self?.request(target, callbackQueue: .main, progress: nil, completion: { (result) in
                         switch result{
                         case .success(let response):
                             if let baseApi = target as? BaseApi{
                                
                                 observer.onNext(self?.transform(target: baseApi, with: response, with: type))
                             }
                         case .failure(let error):
                             print("我的错误请求信息\(error)")
                             /// 判断是否需要缓存
                             if let baseApi = target as? BaseApi{
                                 if baseApi.cacheType == .cache{
                                 }else{
                                     observer.onNext(nil)
                                 }
                             }
                             print("请求失败")
                         }
                     })
                    
                    return Disposables.create {
                        cancellableToken?.cancel()
                    }
                }
            case .unavailable:
                ToastView.instance.showToast(content: "网络连接异常,请检查网络连接!", imageName: "叹号")
                return Observable<AnyObject?>.create { (info) -> Disposable in
                    info.onNext(nil)
                    info.onCompleted()
                    return Disposables.create {}
                }
            default:
                return Observable<AnyObject?>.create { (info) -> Disposable in
                    info.onNext(nil)
                    info.onCompleted()
                    return Disposables.create {}
                }
        }

    }
    
    
    private func transform(target: BaseApi,with response:Response,with responseType:ResponseType) -> AnyObject? {
        
        if response.statusCode == 200{
            do {
                let dic = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                print("请求的状态====\(dic)")
                if (dic?["code"] as? Int ?? 500) == 200 {
                    
                    switch responseType {
                    case .nomal:
                        if JSONSerialization.isValidJSONObject(dic?["data"]){
                            let data = try JSONSerialization.data(withJSONObject: dic?["data"], options: [])
                            if target.cacheType == .cache{
                            }
                            
                        }
                        return dic?["data"] as AnyObject
                    case .netNoData:
                        if target.cacheType == .cache{
                        }
                        return dic?["msg"] as AnyObject?
                    }
                }else if (dic?["code"] as? Int ?? 500) == 401{
                    return nil
                }else if (dic?["code"] as? Int ?? 500) == 50002{
                    return 50002 as AnyObject
                }else{
                    ToastView.instance.showToast(content: dic?["msg"] as? String ?? "", imageName: "叹号")
                    return nil
                }
            } catch {
                return nil
            }
        }else { ///服务器异常
            return nil
        }
    }
}
