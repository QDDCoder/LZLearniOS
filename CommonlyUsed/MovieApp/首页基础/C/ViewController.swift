//
//  ViewController.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/24.
//

import UIKit

var pageStyle:DNSPageStyle{
    let style = DNSPageStyle()
    style.isShowBottomLine=true
    style.isTitleViewScrollEnabled=true
    style.titleFont=UIFont.systemFont(ofSize: 16)
    style.titleViewBackgroundColor=UIColor.clear
    style.titleColor=UIColor.RGB(r: 101, g: 102, b: 104)!
    style.titleSelectedColor=UIColor.RGB(r: 14, g: 185, b: 141)!
    style.bottomLineColor=UIColor.RGB(r: 14, g: 185, b: 141)!
    style.titleMaximumScaleFactor=1.2
    return style
}



class ViewController: LZBaseVC {
    
    // 顶部搜索按钮
    private var searchButton = UIButton().then {
        $0.layer.cornerRadius = 20*PionHeight
        $0.backgroundColor = UIColor.RGB(r: 240, g: 240, b: 240)
        $0.setTitle("搜索", for: .normal)
        $0.setTitleColor(UIColor.RGB(r: 100, g: 100, b: 100), for: .normal)
        $0.frame = CGRect(x: 40*PionWidth, y: STATUSBAR_HEIGHT, width: ScreenW-80*PionWidth, height: 40*PionHeight)
    }
    
    //顶部的分类
    ///科普的title
    private lazy var titleView: DNSPageTitleView = {
        let titleView = DNSPageTitleView(frame: CGRect(x: 0, y: STATUSBAR_HEIGHT+40*PionHeight, width: ScreenW, height: 46*PionHeight), style: pageStyle, titles: topTagModel.map({$0.name}), currentIndex: 0)
        titleView.backgroundColor = .white
        titleView.style.isTitleViewScrollEnabled=true
        titleView.style.isTitleScaleEnabled=false
        titleView.selectedTitle(atIndex: 0)
        titleView.contentView(contentView, didEndScrollAt: 0)
        titleView.delegate = contentView
        contentView.delegate = titleView
        return titleView
    }()
    
    /// 科普的body
    private lazy var contentView: DNSPageContentView = {
        let contentView=DNSPageContentView(frame: CGRect(x: 0, y: STATUSBAR_HEIGHT+40*PionHeight+46*PionHeight, width: ScreenW, height: ScreenH - (STATUSBAR_HEIGHT+40*PionHeight+46*PionHeight)), style: pageStyle, childViewControllers: classChildenVC, currentIndex: 0)
        return contentView
    }()
    
    
    //分类的页面
    private var classChildenVC:[UIViewController] = [UIViewController]()
    private var topTagModel:[HomeTopM]=[HomeTopM]()
    
    //VM
    private lazy var vm: XFSDHomeVM = {
        let vm = XFSDHomeVM()
        vm.output.getHomeTopOut.drive {[weak self] (topInfos) in
            for index in 1 ... 18{
                var model = HomeTopM()
                model.sortId = "\(index)"
                model.name = "分类\(index)"
                self?.topTagModel.append(model)
            }
            self?.setupChildVC()
        }.disposed(by: disposeBag)
        return vm
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup()  {
        self.view.backgroundColor = .white
        self.view.isUserInteractionEnabled=true
        self.view.addSubview(searchButton)
        searchButton.rx.tap.subscribe(onNext: {[weak self] () in
            self?.lz_pushViewController(viewController: LZSearchVC())
        }).disposed(by: disposeBag)
        requestHomeTop()
    }
    
    //请求头部
    private func requestHomeTop()  {
        vm.input.getHomeTopIn.onNext(())
    }
    
    //设置子页面
    private func setupChildVC()  {
        topTagModel.forEach {[weak self] (model) in
            let listVC = HomeListVC()
            listVC.sortId=model.sortId
            listVC.navigator = self?.navigationController
            classChildenVC.append(listVC)
        }
        
        self.view.addSubview(titleView)
        self.view.addSubview(contentView)
    }
}

