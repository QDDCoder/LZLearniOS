//
//  LZBaseDesignPattern.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2021/2/25.
//

import UIKit
import RxSwift
class LZBaseDesignPattern: LZBaseVC {
    private lazy var tableView = UITableView(frame: CGRect(x: 10*PionWidth, y: NAVBAR_HEIGHT, width: ScreenW-20*PionWidth, height: ScreenH-NAVBAR_HEIGHT)).then {
        $0.backgroundColor = .white
        $0.register(LZBaseHomeCell.self, forCellReuseIdentifier: "LZBaseHomeCell")
        $0.rx.setDelegate(self).disposed(by: disposeBag)
        
        //绑定点击事件
        $0.rx.itemSelected.map {[weak self] (indexPath) in
            return (indexPath,self?.dataSource[indexPath.row])
        }.subscribe(onNext: {[weak self](indxPath,model) in
            self?.cellClick(withIndexPath: indxPath)
        }).disposed(by: disposeBag)
        
        //绑定滚动
        $0.rx.contentOffset.map { (point)  in
            // 一般使用纵轴偏移量的多一些
            //return point.y
            let tempOffsetY = abs(point.y)+40
            //根据偏移量 计算颜色值
            let bgColor = UIColor.RGB(r: Int((tempOffsetY/300)*1.0*255), g: Int((tempOffsetY/200)*1.0*255), b: Int((tempOffsetY/100)*1.0*255))
            return bgColor!
        }.bind(to: customTabbar.rx.backgroundColor).disposed(by: disposeBag)
        
        self.view.addSubview($0)
    }
    //数据
    private var dataSource:[String]=["1.单例模式","2.工厂模式","3.抽象工厂模式","4.建造者模式","5.原型模式"
                                     ,"6.适配器模式","7.桥接模式","8.装饰模式","9.组合模式","10.外观模式","11.享元模式","12.代理模式",
                                    "13.模版方法模式","14.命令模式","15.迭代器模式","16.观察者模式","17.中介者模式","18.备忘录模式","19.解释器模式","20.状态模式","21.策略模式","22.职责链模式","23.访问者模式"]
    
    //管道
    private var response:BehaviorSubject<[String]> = BehaviorSubject(value: []).asObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleInfo = "设计模式"
        setup()
    }
    
    private func setup()  {
        //绑定数据
        response.bind(to: tableView.rx.items(cellIdentifier: "LZBaseHomeCell",cellType: LZBaseHomeCell.self)){index, model, cell in
            cell.nameLabel.text = model
        }.disposed(by: disposeBag)
        response.asObserver().onNext(dataSource)
    }
    
    
}

extension LZBaseDesignPattern:UITableViewDelegate{
    //cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44*PionHeight
    }
    
    /// 处理点击事件的处理
    /// - Returns: 点击的indexPath
    private func cellClick(withIndexPath indexPath:IndexPath)  {
        switch indexPath.row+1 {
        /**
         "1.单例模式","2.工厂模式","3.抽象工厂模式","4.建造者模式","5.原型模式"
         */
        
        case 1:
            //单例模式
            lz_pushViewController(viewController: SingleVC())
            break
        case 2:
            //工厂模式
            lz_pushViewController(viewController: FactoryVC())
            break
        case 3:
            //抽象工厂模式
            lz_pushViewController(viewController: AbstractFactoryVC())
            break
        case 4:
            //建造者模式
            lz_pushViewController(viewController: BuilderPatternVC())
            break
        case 5:
            //原型模式
            lz_pushViewController(viewController: PrototypePatternVC())
            break
        /**
         "6.适配器模式","7.桥接模式","8.装饰模式","9.组合模式","10.外观模式","11.享元模式","12.代理模式"
         */
        case 6:
            //适配器模式
            lz_pushViewController(viewController: AdapterPatternVC())
            break
        case 7:
            //桥接模式
            lz_pushViewController(viewController: BridgePatternVC())
            break
        case 8:
            //装饰模式
            lz_pushViewController(viewController: DecoratorPatternVC())
            break
        case 9:
            //组合设计模式
            lz_pushViewController(viewController: CompositePatternVC())
            break
        case 10:
            //外观模式
            lz_pushViewController(viewController: FacadePatternVC())
            break
        case 11:
            //享元模式
            lz_pushViewController(viewController: FlyweightPatternVC())
            break
        case 12:
            //代理模式
            lz_pushViewController(viewController: ProxyPatternVC())
            break
        /**
         "13.模版方法模式","14.命令模式","15.迭代器模式","16.观察者模式","17.中介者模式","18.备忘录模式","19.解释器模式","20.状态模式","21.策略模式","22.职责链模式","23.访问者模式"
         */
        case 13:
            //模板模式
            lz_pushViewController(viewController: TemplateVC())
            break
        case 14:
            //命令模式
            lz_pushViewController(viewController: CommandPatternVC())
            break
        case 15:
            //迭代器模式
            lz_pushViewController(viewController: IteratorPatternVC())
            break
        case 16:
            //观察者模式
            lz_pushViewController(viewController: ObserverPatternVC())
            break
        case 17:
            //中介者模式
            lz_pushViewController(viewController: MediatorPatternVC())
            break
        case 18:
            //备忘录模式
            lz_pushViewController(viewController: MementoPatternVC())
            break
        case 19:
            //解释器模式
            lz_pushViewController(viewController: InterpreterPatternVC())
            break
        case 20:
            //状态模式
            lz_pushViewController(viewController: StatePatternVC())
            break
        case 21:
            //策略模式
            lz_pushViewController(viewController: StrategyPatternVC())
            break
        case 22:
            //责任链模式
            lz_pushViewController(viewController: ChainOfResponsibilityPatternVC())
            break
        case 23:
            //访问者模式
            break
        default:
            break
        }
    }
    
    

}
