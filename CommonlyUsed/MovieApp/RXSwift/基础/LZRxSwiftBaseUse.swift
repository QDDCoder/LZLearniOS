//
//  LZRxSwiftBaseUse.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/25.
//

import UIKit
import RxSwift
import RxCocoa

class LZRxSwiftBaseUse: LZBaseVC {

    var response:ConnectableObservable<Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenTopBar=false
        titleInfo = "基础使用"
        setObservable()
        Observer()
        OO()
        Operator()
    }
    
    //可观察序列
    private func setObservable()  {
        //1.single - 只能发出一个元素，要么产生一个 error 事件
        let single = Single<String>.create { single in
            //只会执行第一个
            single(.success("哈哈"))
            single(.error(NSError(domain: "出错了", code: 1001, userInfo: nil)))
            return Disposables.create {
                
            }
        }
        single.subscribe(onSuccess: {result in
            print("结果信息是:\(result)")
        }, onError: {error in
            print("错误信息是:\(error)")
        }).disposed(by: disposeBag)
        
        
        //2.Completable: 要么只能产生一个 completed 事件，要么产生一个 error 事件。
        let completed = Completable.create { (comp)  in
            comp(.completed)
            comp(.error(NSError(domain: "哈哈", code: 1002, userInfo: nil)))
            return Disposables.create {
                
            }
        }
        completed.subscribe(onCompleted: {
            print("完成")
        }, onError: {error in
            print("出错了\(error)")
        }).disposed(by: disposeBag)
        
        
        //3.Maybe : 它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件
        let maybe = Maybe<String>.create { (maybe)  in
            maybe(.success("啊哈哈"))
            maybe(.completed)
            maybe(.error(NSError(domain: "出错了", code: 1001, userInfo: nil)))
            return Disposables.create {
            }
        }
        maybe.subscribe(onSuccess: {result in
            print("信息=>\(result)")
        }, onError: {error in
            print("失败\(error)")
        }, onCompleted: {
            print("完成了")
        }).disposed(by: disposeBag)
        
        
        //4.Driver : 不会产生error,主线程,共享附加
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(button)
        button.backgroundColor = .randomColor
        let eventDr=button.rx.tap.asDriver()
        eventDr.map({UIColor.randomColor}).drive(onNext: {[weak self]color in
            self?.view.backgroundColor=color
            //会对之前的点击事件进行回放 合适的做法就是分开订阅
            print("嘿嘿点击了啊first")
            eventDr.drive(onNext: {
                print("嘿嘿点击了啊")
            }).disposed(by: self!.disposeBag)
        }).disposed(by: disposeBag)
        
        
        
        //5. Signal : Signal和Driver相似，唯一的区别是，Driver会对新观察者回放（重新发送）上一个元素，而Signal 不会对新观察者回放上一个元素
        let buttonSingle = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        self.view.addSubview(buttonSingle)
        buttonSingle.backgroundColor = .randomColor
        let eventSingle=buttonSingle.rx.tap.asSignal()
        eventSingle.map({UIColor.randomColor}).emit(onNext: {[weak self]color in
            self?.view.backgroundColor=color
            print("嘿嘿点击了2222啊first")
            eventSingle.emit(onNext: {
                print("嘿嘿点击了2222啊")
            }).disposed(by: self!.disposeBag)
        }).disposed(by: disposeBag)
        
        
        //6. ControlEvent : 专门用于描述 UI 控件所产生的事件
        let buttonEvent = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        self.view.addSubview(buttonEvent)
        buttonEvent.backgroundColor = .randomColor
        buttonEvent.rx.controlEvent(.touchUpInside).map({UIColor.randomColor}).bind(to: self.view.rx.backgroundColor).disposed(by: disposeBag)
    }
    
    
    /// 观察者
    /// - Returns:
    private func Observer()  {
        //1. AnyObserver： 可以用来描叙任意一种观察者。
        //相当于是subscribe 单独写了
        let observer: AnyObserver<Data> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print("Data Task Success with count: \(data.count)")
            case .error(let error):
                print("Data Task Error: \(error)")
            default:
                break
            }
        }
        URLSession.shared.rx.data(request: URLRequest(url: URL(string: "https://tcc.taobao.com/cc/json/mobile_tel_segment.htm?tel=18337152032")!))
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        
        //2. Binder: 不会处理错误事件,确保绑定都是在给定Scheduler上执行（默认 MainScheduler）
        let buttonBinder = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 100))
        buttonBinder.backgroundColor = .randomColor
        self.view.addSubview(buttonBinder)
        let binder = Binder<Bool>.init(buttonBinder) { (viewIn,isHidden)  in
            viewIn.isHidden = isHidden
        }
        buttonBinder.rx.controlEvent(.touchUpInside).map({true}).bind(to: binder).disposed(by: disposeBag)
        
    }
 
    
    /// 既是可监听序列也是观察者
    private func OO()  {
        //1. AsyncSubject : 将在源 Observable 产生完成事件后，发出最后一个元素（仅仅只有最后一个元素），如果源 Observable 没有发出任何元素，只有一个完成事件。那 AsyncSubject 也只有一个完成事件。如果源 Observable 因为产生了一个 error 事件而中止， AsyncSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
        let subject = AsyncSubject<String>()
        subject.subscribe { (info) in
            print("subject==>\(info)")
        }.disposed(by: disposeBag)
        subject.onNext("嘿嘿")
        subject.onNext("嘿嘿2")
        //完成和异常只有一个
        subject.onCompleted()
        subject.onError(NSError(domain: "嘿嘿,出错了", code: 1001, userInfo: nil))
        
        
        //2.PublishSubject : 将对观察者发送订阅后产生的元素，而在订阅前发出的元素将不会发送给观察者。如果你希望观察者接收到所有的元素，你可以通过使用 Observable 的 create 方法来创建 Observable，或者使用 ReplaySubject。
        let publish = PublishSubject<String>()
        publish.subscribe { (event) in
            print("publish==>\(event)")
        }.disposed(by: disposeBag)
        publish.onNext("嘿嘿")
        publish.subscribe { (event) in
            print("接收到的信息publish22=>\(event)")
        }.disposed(by: disposeBag)
        publish.onNext("嘿嘿2")
        
        publish.onCompleted()
        publish.onError(NSError(domain: "嘿嘿,出错了", code: 1002, userInfo: nil))
        
        
        //3.ReplaySubject : 将对观察者发送全部的元素，无论观察者是何时进行订阅的。这里存在多个版本的 ReplaySubject，有的只会将最新的 n 个元素发送给观察者，有的只会将限制时间段内最新的元素发送给观察者。如果把 ReplaySubject 当作观察者来使用，注意不要在多个线程调用 onNext, onError 或 onCompleted。这样会导致无序调用，将造成意想不到的结果.
        let replay = ReplaySubject<String>.create(bufferSize: 1)
        replay.subscribe { (event) in
            switch event{
            case .next(let info):
                print("replay==>\(info)")
            case .error(let error):
                print("replay==>error==>>\(error)")
            case .completed:
                print("replay==>completed==>>")
            }
            
        }.disposed(by: disposeBag)
        replay.onNext("嘿嘿2")
        replay.onNext("嘿嘿3")
        replay.subscribe { (event) in
            switch event{
            case .next(let info):
                print("replay==>\(info)")
            case .error(let error):
                print("replay==>error==>>\(error)")
            case .completed:
                print("replay==>completed==>>")
            }
        }.disposed(by: disposeBag)
        replay.onNext("嘿嘿4")
        replay.onNext("嘿嘿5")
     
        
        //4. BehaviorSubject: 当观察者对 BehaviorSubject 进行订阅时，它会将源 Observable 中最新的元素发送出来（如果不存在最新的元素，就发出默认元素）。然后将随后产生的元素发送出来。如果源 Observable 因为产生了一个 error 事件而中止， BehaviorSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
        let behavior = BehaviorSubject<String>.init(value: "初始元素")
        behavior.subscribe { (event) in
            print("behavior==>\(event)")
        }.disposed(by: disposeBag)
        behavior.onNext("嘿嘿")
        behavior.onNext("嘿嘿2")
        behavior.subscribe { (event) in
            print("behavior==>\(event)")
        }.disposed(by: disposeBag)
        behavior.onNext("嘿嘿3")
        behavior.onNext("嘿嘿4")
        behavior.onCompleted()
        
        
        //5. ControlProperty: 专门用于描述 UI 控件属性的,不会产生 error 事件,一定在 MainScheduler 订阅（主线程订阅）,一定在 MainScheduler 监听（主线程监听） 作用:起到了中间承接,确保队列和观察者处于主线程,具体逻辑需要处理
        let controlBinder = UIView(frame: CGRect(x: 100, y: 500, width: 100, height: 100))
        controlBinder.backgroundColor = .randomColor
        self.view.addSubview(controlBinder)
        
        let replay2 = ReplaySubject<Bool>.create(bufferSize: 1)
        let name = ControlProperty(values: replay2.asObservable(), valueSink: controlBinder.rx.isHidden)
        name.asObservable().bind(to: controlBinder.rx.isHidden).disposed(by: disposeBag)
        name.subscribe { (event) in
            print("Control ==>\(event)")
        }.disposed(by: disposeBag)
        replay2.onNext(true)
        //name.onNext(true)
    }
    
    
    /// 操作符
    private func Operator()  {
        //------------------------组合-------------------------
        // 1. startWidth 一个新的 Observable 在原有的序列前面加入一些元素
        var observableStart = Observable.of(1,2,3,4)
        observableStart = observableStart.startWith(-1,0)
        observableStart.subscribe(onNext: {(info) in
            print("接收到的信息=startWith==>\(info)")
        }).disposed(by: disposeBag)
        
        
        // 2. merge 创建一个 Observable 通过组合其他的 Observables,任意一个 Observable 产生了元素,就发出这个元素
        let observableMerge1 = Observable.of("1","2","3")
        let observableMerge2 = Observable.of("a","b","c","d")
        Observable.merge(observableMerge1,observableMerge2).subscribe(onNext: {(info) in
            print("组合的信息=merge==>\(info)")
        }).disposed(by: disposeBag)
        
        
        //3.zip 组合多个 Observables 的元素,当每一个 Observable 都发出一个新的元素
        let observableZip1 = Observable.of("1","2","3")
        let observableZip2 = Observable.of("a","b","c","d")
        //返回元组信息
        Observable.zip(observableZip1,observableZip2).subscribe(onNext: {(info) in
            print("组合的信息=zip==>\(info)")
        }).disposed(by: disposeBag)
        
        //4. combineLatest 组合多个 Observables 的元素,当任意一个 Observable 发出一个新的元素
        /*
         组合的信息=CombineLatest==>("1", "a")
         组合的信息=CombineLatest==>("2", "a")
         组合的信息=CombineLatest==>("2", "b")
         组合的信息=CombineLatest==>("3", "b")
         组合的信息=CombineLatest==>("3", "c")
         组合的信息=CombineLatest==>("3", "d")
         和merge区别在于merge发出单个元素，zip和combineLatest都是发出元组类型的新元素
         */
        let observableCombineLatest1 = Observable.of("1","2","3")
        let observableCombineLatest2 = Observable.of("a","b","c","d")
        Observable.combineLatest(observableCombineLatest1, observableCombineLatest2).subscribe(onNext: {(info) in
            print("组合的信息=CombineLatest==>\(info)")
        }).disposed(by: disposeBag)
        
        
        //------------------------映射-------------------------
        //1.map
        let observableMap1 = Observable.of(1,2,3)
        observableMap1.map({$0+1}).subscribe(onNext: {(info) in
            print("组合的信息=Map==>\(info)")
        }).disposed(by: disposeBag)
        
        
        //2.flatMap
        let observableFlatMap1 = Observable.of(1,2,3)
        observableFlatMap1.flatMap({Observable<String>.of(">>\($0)")}).subscribe(onNext: {(info) in
            print("flatMap的变换\(info)")
        }).disposed(by: disposeBag)
        
        
        //3.flatMapLatest : 将 Observable 的元素转换成其他的 Observable，然后取这些 Observables 中最新的一个
        let observableFlatMapLatest1 = BehaviorSubject(value: 1)
        observableFlatMapLatest1.flatMapLatest({Observable<Int>.of($0+1)}).subscribe(onNext: {(info) in
            print("flatMapLatest的变换\(info)")
        }).disposed(by: disposeBag)
        observableFlatMapLatest1.onNext(2)
        observableFlatMapLatest1.flatMapLatest({Observable<Int>.of($0*2)}).subscribe(onNext: {(info) in
            print("flatMapLatest的变换\(info)")
        }).disposed(by: disposeBag)
        observableFlatMapLatest1.onNext(3)
        
        
        //4.concatMap : 每一个元素转换的 Observable 按顺序产生元素
        /**
         ConcatMap的变换aa==>101
         ConcatMap的变换bb==>210
         ConcatMap的变换bb==>220
         ConcatMap的变换aa==>102
         */
        let observableConcatMap1 = BehaviorSubject(value: 1)
        let observableConcatMap2 = BehaviorSubject(value: 10)
        observableConcatMap1.concatMap({Observable<Int>.of($0+100)}).subscribe(onNext: {info in
            print("ConcatMap的变换aa==>\(info)")
        }).disposed(by: disposeBag)
        observableConcatMap2.concatMap({Observable<Int>.of($0+200)}).subscribe(onNext: {info in
            print("ConcatMap的变换bb==>\(info)")
        }).disposed(by: disposeBag)
        observableConcatMap2.onNext(20)
        observableConcatMap1.onNext(2)
        
        
        //5.scan : 基于所有遍历过的元素,操作符将对第一个元素应用一个函数，将结果作为第一个元素发出。然后，将结果作为参数填入到第二个元素的应用函数中，创建第二个元素。以此类推，直到遍历完全部的元素。 1,2,3求和过程
        let observableScan1 = Observable.of(1,2,3)
        observableScan1.scan(0) { (old, new)  in
            return old + new
        }.subscribe(onNext: {info in
            print("scan的变换==>\(info)")
        }).disposed(by: disposeBag)
        
        
        
        //------------------------过滤-------------------------
        //1.filter
        let observableFilter = Observable.of(1,2,3,4)
        observableFilter.filter({$0%2==0}).subscribe(onNext: {info in
            print("Filter的过滤==>\(info)")
        }).disposed(by: disposeBag)
        
        
        //2.distinctUntilChanged : 阻止 Observable 发出相同的元素
        let observableDistinctUntilChanged = Observable.of(1,2,2,3,3,4)
        observableDistinctUntilChanged.distinctUntilChanged().subscribe { (info) in
            print("distinctUntilChanged的过滤==>\(info)")
        }.disposed(by: disposeBag)
        
        
        //3.elementAt: 发出指定的第几个元素
        let observableElementAt = Observable.of(1,2,2,3,3,4)
        observableElementAt.elementAt(1).subscribe { (info) in
            print("elementAt的过滤==>\(info)")
        }.disposed(by: disposeBag)
        
        
        //4.single : 限制 Observable 只发出一个元素，否出发出一个 error 事件
        let observableSingle = Observable.of(1,2,2,3,3,4)
        observableSingle.single().subscribe { (info) in
            print("single的过滤==>\(info)")
        }.disposed(by: disposeBag)
        
        
        //5.take : 仅仅发出头几个指定元素
        let observableTake = Observable.of(1,2,2,3,3,4)
        observableTake.take(3).subscribe { (info) in
            print("take的过滤==>\(info)")
        }.disposed(by: disposeBag)
        
        
        //6.takeLast: 仅从可观察序列的尾部发出指定数量元素,非倒序
        let observableTakeLast = Observable.of(1,2,2,3,3,4)
        observableTakeLast.takeLast(3).subscribe { (info) in
            print("takeLast的过滤==>\(info)")
        }.disposed(by: disposeBag)
        
        
        //7.takeWhile: 直到某个元素的判定为 false,当第一个不满足条件的值出现时，它便自动完成。
        //注意此时只能小于取满足左侧的数据
        /**
         takeWhile的过滤==>1
         takeWhile的过滤==>2
         */
        let observableTakeWhile = Observable.of(1,2,10,2,3,3,4)
        observableTakeWhile.takeWhile({$0<=2}).subscribe(onNext: {info in
            print("takeWhile的过滤==>\(info)")
        }).disposed(by: disposeBag)
        
        
        //8.takeUntil: 它同时观测第二个 Observable。一旦第二个 Observable 发出一个元素或者产生一个终止事件，那个镜像的 Observable 将立即终止。
        let observableTakeUntil1 = BehaviorSubject(value: 1)
        let observableTakeUntil2 = BehaviorSubject(value: 10)
        observableTakeUntil1.takeUntil(observableTakeUntil2).subscribe(onNext: {info in
            print("takeUntil的过滤==>\(info)")
        }).disposed(by: disposeBag)
        observableTakeUntil1.onNext(2)
        observableTakeUntil2.onNext(20)
        observableTakeUntil1.onNext(3)

        
        //9.skip: 跳过 Observable 中头 n 个元素
        var observableSkip = Observable.of(1,2,3,4,5)
        observableSkip = observableSkip.skip(2)
        observableSkip.subscribe(onNext: {info in
            print("skip的过滤==>\(info)")
        }).disposed(by: disposeBag)
        
        
        //10.skipUntil : 跳过 Observable 中头几个元素，直到另一个 Observable 发出一个元素
        let observableSkipUntil1 = BehaviorSubject(value: 1)
        let observableSkipUntil2 = BehaviorSubject(value: 10)
        let observableSkipUntil3 = observableSkipUntil1.skipUntil(observableSkipUntil2)
        observableSkipUntil3.subscribe(onNext: {info in
            print("skipUntil的过滤==>\(info)")
        }).disposed(by: disposeBag)
        observableSkipUntil1.onNext(2)
        observableSkipUntil2.onNext(20)
        observableSkipUntil1.onNext(3)
        
        
        
        //------------------------集合控制-------------------------
        //1.toArray : 可观察序列转换为一个数组
        let observableToArray = Observable.of(1,2,3,4,5)
        _ = observableToArray.toArray().subscribe(onSuccess: {info in
            print("toArray的集合控制==>\(info)")
        }).disposed(by: disposeBag)
        
        
        //2.reduce: 持续的将 Observable 的每一个元素应用一个函数，然后发出最终结果
        /**
         reduce与scan非常相似，区别在于scan会把每次的计算结果回传给下游,而reduce只会回传结果
         */
        let observableReduce = Observable.of(1,2,3,4,5)
        observableReduce.reduce(0, accumulator: +).subscribe { (event) in
            print("reduce的集合控制==>\(event)")
        }.disposed(by: disposeBag)
        
        
        
        //3.concat: 让两个或多个 Observables 按顺序串连起来,将多个 Observables 按顺序串联起来，当前一个 Observable 元素发送完毕后，后一个 Observable 才可以开始发出元素。等待前一个 Observable 产生完成事件后，才对后一个 Observable 进行订阅。如果后一个是“热” Observable ，在它前一个 Observable 产生完成事件前，所产生的元素将不会被发送出来。
        let observableConcat1 = Observable.of(1,2,3,4,5)
        let observableConcat2 = Observable.of(10,20,30,40,50)
        observableConcat1.concat(observableConcat2).subscribe(onNext: {info in
            print("Concat的集合控制==>\(info)")
        }).disposed(by: disposeBag)
        
        
        //------------------------从错误通知中恢复-------------------------
        //1.catchError:从一个错误事件中恢复，将错误事件替换成一个备选序列
        let observableCatchError1 = BehaviorSubject(value: 1)
        observableCatchError1.catchError { (error) -> Observable<Int> in
            return Observable.of(100)
        }.subscribe(onNext: {info in
            print("catchError的错误通知中恢复==>\(info)")
        }).disposed(by: disposeBag)
        observableCatchError1.onNext(2)
        observableCatchError1.onError(NSError(domain: "哈哈", code: 100, userInfo: nil))
        
        
        //2.catchErrorJustReturn: catchErrorJustReturn 操作符会将error 事件替换成其他的一个元素
        let observableCatchErrorJustReturn = BehaviorSubject(value: 1)
        observableCatchErrorJustReturn.catchErrorJustReturn(100).subscribe(onNext: {info in
            print("catchErrorJustReturn的错误通知中恢复==>\(info)")
        }).disposed(by: disposeBag)
        observableCatchErrorJustReturn.onNext(2)
        observableCatchErrorJustReturn.onError(NSError(domain: "嘿嘿", code: 1000, userInfo: nil))
        
        
        //3.retry: 通过无限重新订阅来恢复重复的错误事件
        /**
         Retry的错误通知中恢复==>🍎
         Retry的错误通知中恢复==>🍐
         Retry的错误通知中恢复==>🍊
         Retry的错误通知中恢复==>🍎
         Retry的错误通知中恢复==>🍐
         Retry的错误通知中恢复==>🍊
         Retry的错误通知中恢复==>🐶
         Retry的错误通知中恢复==>🐱
         Retry的错误通知中恢复==>🐭
         */
        var count = 1
        let observableRetry = Observable<String>.create { observer in
            observer.onNext("🍎")
            observer.onNext("🍐")
            observer.onNext("🍊")
            if count == 1{
                observer.onError(NSError(domain: "哈哈", code: 1003, userInfo: nil))
                count+=1
            }
            observer.onNext("🐶")
            observer.onNext("🐱")
            observer.onNext("🐭")
            observer.onCompleted()

            return Disposables.create()
        }
        observableRetry.retry(2).subscribe(onNext: {info in
            print("Retry的错误通知中恢复==>\(info)")
        }).disposed(by: disposeBag)
        
        
    
        //------------------------debug-------------------------
        let observableDebug = Observable.of(1,2,3,4,5)
        observableDebug.debug().subscribe(onNext: {info in
            print("debug的debug==>\(info)")
        }).disposed(by: disposeBag)
        

        //------------------------链接-------------------------
        /**
         可连接的序列（Connectable Observable）：
         （1）可连接的序列和一般序列不同在于：有订阅时不会立刻开始发送事件消息，只有当调用 connect() 之后才会开始发送值。
         （2）可连接的序列可以让所有的订阅者订阅后，才开始发出事件消息，从而保证我们想要的所有订阅者都能接收到事件消息。
         */
        
        //1.publish: 将 Observable 转换为可被连接的 Observable,使用connect后开始发送数据
        /**
         链接的Publish1: next(2)
         链接的Publish1: next(3)
         链接的Publish1: next(4)
         链接的Publish2: 4
         */
        let observablePublish1 = PublishSubject<Int>()
        let observablePublish2 = observablePublish1.publish()
        observablePublish2.subscribe { (info) in
            print("链接的Publish1: \(info)")
        }.disposed(by: disposeBag)
        observablePublish1.onNext(1)
        observablePublish2.connect()
        observablePublish1.onNext(2)
        observablePublish1.onNext(3)
        observablePublish1.subscribe(onNext: { print("链接的Publish2: \($0)") })
        observablePublish1.onNext(4)
        
        
        //2.replay: replay与publish相似 。不同:将 Observable 转换为可被连接的 Observable。共享队列,需要缓存大小参数。新订阅者发送缓存之前数据。
        /**
         链接的Replay1: 2
         链接的Replay1: 3
         链接的Replay2: 2
         链接的Replay2: 3
         链接的Replay1: 4
         链接的Replay2: 4
         */
        let observableReplay1 = PublishSubject<Int>()
        let observableReplay2 = observableReplay1.replay(2)
        observableReplay2.subscribe(onNext: {info in
            print("链接的Replay1: \(info)")
        }).disposed(by: disposeBag)
        observableReplay1.onNext(1)
        observableReplay2.connect()
        observableReplay1.onNext(2)
        observableReplay1.onNext(3)
        observableReplay2.subscribe(onNext: { print("链接的Replay2: \($0)") })
        observableReplay1.onNext(4)
        
        //3.multicast:与Pushlish 相似。不同: multicast 方法还可以传入一个 Subject，每当序列发送事件时都会触发这个 Subject 的发送。
        /**
         链接的multicast==>1
         链接的multicast2: 1
         链接的multicast==>1000
         链接的multicast2: 1000
         */
        let subject = PublishSubject<Int>()
        let observableMulticast1 = PublishSubject<Int>()
        let observableMulticast2 = observableMulticast1.multicast(subject)
        observableMulticast2.subscribe(onNext: {info in
            print("链接的multicast==>\(info)")
        }).disposed(by: disposeBag)
        observableMulticast1.onNext(0)
        _ = observableMulticast2.connect()
        observableMulticast2.subscribe(onNext: { print("链接的multicast2: \($0)") })
        observableMulticast1.onNext(1)
        subject.onNext(1000)
    }
    
}
