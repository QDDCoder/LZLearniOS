//
//  LZRXSwiftVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/25.
//

import UIKit
import RxDataSources
import RxSwift
class LZRXSwiftVC: LZBaseVC {
    
    
    private lazy var tableView = UITableView(frame: CGRect(x: 10*PionWidth, y: NAVBAR_HEIGHT, width: ScreenW-20*PionWidth, height: ScreenH-NAVBAR_HEIGHT)).then {
        $0.backgroundColor = .white
        $0.register(LZBaseHomeCell.self, forCellReuseIdentifier: "LZBaseHomeCell")
    }
    var dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, HomeCategoryModel>> { (_, tableView, indexPath, item) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "LZBaseHomeCell", for: indexPath) as! LZBaseHomeCell
        cell.nameLabel.text=item.name
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpData()
    }
    private func setup()  {
        titleInfo = "RXSwift"
        self.view.addSubview(tableView)
    }
    private func setUpData()  {
        let dataS = BehaviorSubject.init(
            value:[SectionModel(model: "1", items:
                [
                    HomeCategoryModel(withName: "基础使用", withJump: LZRxSwiftBaseUse.self),
                    HomeCategoryModel(withName: "TableView-row", withJump: LZRXSwiftTableRowView.self),
                    HomeCategoryModel(withName: "TableView-section", withJump: LZRXSwiftTableSectionView.self),
                    HomeCategoryModel(withName: "CollectionView-row", withJump: LZRXCollectionViewRowVC.self),
                    HomeCategoryModel(withName: "CollectionView-section", withJump: LZRXCollectionViewSectionVC.self),
                    HomeCategoryModel(withName: "网络库", withJump: LZRxSwiftBaseUse.self),
                    HomeCategoryModel(withName: "RXSwift的APP架构-MVVM", withJump: LZRxSwiftBaseUse.self),
                    HomeCategoryModel(withName: "RXSwift的APP架构-RxFeedback", withJump: LZRxSwiftBaseUse.self),
                    HomeCategoryModel(withName: "RXSwift的APP架构-ReactorKit", withJump: LZRxSwiftBaseUse.self),
                    HomeCategoryModel(withName: "RXSwift的泛型扩展", withJump: LZRxSwiftBaseUse.self),
                ]
            )])
        dataS.asObserver().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        tableView.rx.itemSelected.map {[weak self] (indexPath)  in
            return (indexPath,self!.dataSource[indexPath])
        }.subscribe(onNext: {[weak self](indexPath,model) in
            self?.lz_pushViewController(viewController: model.jump.init())
        }).disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension LZRXSwiftVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40*PionHeight
    }
}
