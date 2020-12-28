//
//  XFSDHomeVM.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/24.
//

import UIKit
import RxCocoa
import RxSwift
class XFSDHomeVM: ViewModelOrderType {
    var input: Input!
    var output: Output!
    struct Input {
        ///获取首页
        let getHomeTopIn:AnyObserver<Void>
    }
    
    struct Output {
        let getHomeTopOut:Driver<[HomeTopM]>
    }
    
    ///获取首页的转换体
    private var getHomeInputSubject:ReplaySubject<Void> = ReplaySubject<Void>.create(bufferSize: 1)
    
    init() {
        let getHomeInfoGreeting = getHomeInputSubject.asObserver().flatMapLatest {[weak self] (params) -> Observable<[HomeTopM]> in
            return (self?.getHomeData())!
        }
        input=Input(getHomeTopIn: getHomeInputSubject.asObserver())
        output=Output(getHomeTopOut: getHomeInfoGreeting.asDriver(onErrorJustReturn: ([])))
    }
    
    private func getHomeData() -> Observable<[HomeTopM]> {
        let params:Dictionary<String,Any> = Dictionary<String,String>()
        
        let response:Observable<[HomeTopM]> = LZRequestManager.homeApi.getResponse(target: .getHomeTopInfo(params)).map {[weak self] (data) -> [HomeTopM] in
            if data == nil{
                return []
            }
            return []
        }
        return response
    }
}
