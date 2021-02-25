//
//  LZBaseVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/25.
//

import UIKit
import RxSwift
import RxDataSources
//首页导航栏
class LZBaseHomeVC: LZBaseVC {
    
    private let tableView:UITableView = UITableView(frame: CGRect(x: 20*PionWidth, y: NAVBAR_HEIGHT, width: ScreenW-40*PionWidth, height: ScreenH)).then {
        $0.backgroundColor = .white
        $0.register(LZBaseHomeCell.self, forCellReuseIdentifier: "LZBaseHomeCell")
        $0.estimatedRowHeight = 40.0
        $0.separatorStyle = .none
        
    }
    
    private var dataSource:[SectionModel]=[SectionModel<String, HomeCategoryModel>]()
    
    var dataSourceSection = RxTableViewSectionedReloadDataSource<SectionModel<String, HomeCategoryModel>> { (_, tableview, index, sectionModel) -> UITableViewCell in
        let cell = tableview.dequeueReusableCell(withIdentifier: "LZBaseHomeCell", for: index) as! LZBaseHomeCell
        cell.nameLabel.text = sectionModel.name
        cell.backgroundColor = UIColor.RGB(r: 240, g: 240, b: 240)

        return cell
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setData()
    }
    private func setup()  {
        self.titleInfo = "分类"
        hiddenBackButton=true
        self.view.addSubview(tableView)
        
    }
    private func setData()  {
                
        dataSource.append(SectionModel(model: "首页基础", items: [HomeCategoryModel(withName: "首页基础", withJump: ViewController.self),HomeCategoryModel(withName: "RXSwift", withJump: LZRXSwiftVC.self),HomeCategoryModel(withName: "23种设计模式", withJump: LZBaseDesignPattern.self)]))
        
        let dataOB = BehaviorSubject.init(value: dataSource).asObserver()
        dataOB.bind(to: tableView.rx.items(dataSource: dataSourceSection)).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.map {[weak self](indexPath) in
            return (indexPath,self!.dataSourceSection[indexPath])
        }.subscribe(onNext: {[weak self](index,model) in
            self?.lz_pushViewController(viewController: model.jump.init())
        }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
    }
}

extension LZBaseHomeVC : UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40*PionHeight
    }
}


class LZBaseHomeCell: UITableViewCell {
    var nameLabel = UILabel().then {
        $0.textColor = UIColor.RGB(r: 100, g: 100, b: 100)
        $0.numberOfLines=0
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HomeCategoryModel: NSObject {
    var name:String = ""
    var jump:UIViewController.Type = UIViewController.self
    
    init(withName name:String,withJump jump:UIViewController.Type) {
        super.init()
        self.name=name
        self.jump=jump
    }
}
