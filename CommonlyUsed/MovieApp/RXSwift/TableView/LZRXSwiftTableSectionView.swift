//
//  LZRXSwiftTableSectionView.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/26.
//

import UIKit
import RxSwift
import RxDataSources

class LZRXSwiftTableSectionView: LZBaseVC {

    private lazy var tableView = UITableView(frame: CGRect(x: 10*PionWidth, y: NAVBAR_HEIGHT, width: ScreenW-20*PionWidth, height: ScreenH-NAVBAR_HEIGHT)).then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(LZBaseHomeCell.self, forCellReuseIdentifier: "LZBaseHomeCell")
        $0.rx.setDelegate(self).disposed(by: disposeBag)
        $0.dropDelegate=self
        /// 程序内拖拽功能开启,默认ipad为true,iphone为false
        $0.dragInteractionEnabled = true
        //系统自动调整scrollView.contentInset保证滚动视图不被tabbar,navigationbar遮挡
        $0.contentInsetAdjustmentBehavior = .scrollableAxes
        self.view.addSubview($0)
    }
    
    //设置数据绑定的中间件
    private var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,HomeCategoryModel>> { (_, tableView, indexPath, item) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "LZBaseHomeCell", for: indexPath) as! LZBaseHomeCell
        cell.nameLabel.text=item.name
        cell.backgroundColor = .randomColor
        //为cell注册拖拽方法
        cell.userInteractionEnabledWhileDragging = true
        return cell
    }.then {
        
        //设置section的header
        $0.titleForHeaderInSection={(dataSourceIn,section) ->String in
            return dataSourceIn[section].model
        }
        
        //设置section的footer
        $0.titleForFooterInSection={(dataSourceIn,section) ->String in
            return dataSourceIn[section].model
        }
        
        //设置可移动
        $0.canMoveRowAtIndexPath={(dataSourceIn,indexPath) -> Bool in
            return true
        }
        
        //设置可编辑
        $0.canEditRowAtIndexPath={(dataSourceIn,indexPath) -> Bool in
            if dataSourceIn[indexPath].name == "第一个"{
                return true
            }
            return false
        }
    }
    
    //创造数据
    private var response:BehaviorSubject<[SectionModel<String, HomeCategoryModel>]>?
    private var dataModel=[SectionModel(model: "base", items:
                        [
                            HomeCategoryModel(withName: "第一个", withJump: UIViewController.self),
                            HomeCategoryModel(withName: "第二个", withJump: UIViewController.self),
                            HomeCategoryModel(withName: "第三个", withJump: UIViewController.self),
                        ]),
                        SectionModel(model: "base2", items:
                        [
                            HomeCategoryModel(withName: "第一个", withJump: UIViewController.self),
                            HomeCategoryModel(withName: "第二个", withJump: UIViewController.self),
                            HomeCategoryModel(withName: "第三个", withJump: UIViewController.self),
                        ])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleInfo="tableView-section"
        setData()
    }
    
    private func setData()  {
        
        //创造数据
        response = BehaviorSubject(value:dataModel)
        
        //绑定数据
        response!.asObserver().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        //设置点击事件
        tableView.rx.itemSelected.map {[weak self] (indexPath) in
            return (indexPath,self!.dataSource[indexPath])
        }.subscribe(onNext:{(index,model) in
            ToastView.instance.showToast(content: "点击了===>>>\(index.section)===>>>\(model.name)")
        }).disposed(by: disposeBag)
    }
}

// 设置 高度和事件
extension LZRXSwiftTableSectionView : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80*PionHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40*PionHeight
    }
    
    //cell的编辑事件
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .destructive, title: "哈哈", handler: {[weak self] (action, index) in
            ToastView.instance.showToast(content: "事件")
            self?.dataModel[index.section].items.remove(at: index.row)
            self?.response?.onNext(self!.dataModel)
        })]
    }
    
}
// cell 拖动
extension LZRXSwiftTableSectionView:UITableViewDropDelegate
{
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
    }
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    // cell的动画执行完毕后 执行一次数据交换
    func tableView(_ tableView: UITableView, dropSessionDidEnd session: UIDropSession) {
        dataModel = dataSource.sectionModels
        response?.onNext(dataModel)
    }
}
