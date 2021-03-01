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
    private var dataSource:[String]=["单例模式","工厂模式","抽象工厂模式","模板模式"]
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
        switch indexPath.row {
        case 0:
            //单例模式
            lz_pushViewController(viewController: SingleVC())
            break
        case 1:
            //工厂模式
            lz_pushViewController(viewController: FactoryVC())
            break
        case 2:
            //抽象工厂模式
            lz_pushViewController(viewController: AbstractFactoryVC())
            break
        case 3:
            //模板模式
            lz_pushViewController(viewController: TemplateVC())
            break
        default:
            break
        }
    }
    
    

}
