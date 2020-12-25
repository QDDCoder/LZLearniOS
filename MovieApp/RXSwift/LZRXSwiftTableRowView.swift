//
//  LZRXSwiftTableRowView.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/25.
//

import UIKit
import RxSwift
class LZRXSwiftTableRowView: LZBaseVC {
    
    private lazy var tableView = UITableView(frame: CGRect(x: 10*PionWidth, y: NAVBAR_HEIGHT, width: ScreenW-20*PionWidth, height: ScreenH-NAVBAR_HEIGHT)).then {
        $0.backgroundColor = .white
        $0.register(LZBaseHomeCell.self, forCellReuseIdentifier: "LZBaseHomeCell")
        $0.rx.setDelegate(self).disposed(by: disposeBag)
        
        //绑定点击事件
        $0.rx.itemSelected.map {[weak self] (indexPath) in
            return (indexPath,self?.dataSource[indexPath.row])
        }.subscribe(onNext: {(indxPath,model) in
            ToastView.instance.showToast(content: "点击了\(model ?? "")")
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
    private var dataSource:[String]=["1","2","3"]
    //管道
    private var response:BehaviorSubject<[String]> = BehaviorSubject(value: []).asObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleInfo = "tableView-row"
        setup()
    }
    
    private func setup()  {
        //绑定数据
        response.bind(to: tableView.rx.items(cellIdentifier: "LZBaseHomeCell",cellType: LZBaseHomeCell.self)){index, model, cell in
            cell.nameLabel.text = model
        }.disposed(by: disposeBag)
        
        //修改数据
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self] in
            self?.response.asObserver().onNext(self!.dataSource)
        }
    }
}

extension LZRXSwiftTableRowView:UITableViewDelegate{
    //cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44*PionHeight
    }
    
    // 处理cell的编辑事件
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction.init(style: .normal, title: "嘿嘿", handler: {[weak self] (action, indexPath) in
            //数据双向绑定
            self?.dataSource.remove(at: indexPath.row)
            self?.response.asObserver().onNext(self!.dataSource)
        })]
    }
}
