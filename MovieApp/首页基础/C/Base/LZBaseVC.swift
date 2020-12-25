//
//  LZBaseVC.swift
//  xfsdny
//
//  Created by 湛亚磊 on 2020/4/3.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import IQKeyboardManagerSwift
class LZBaseVC: UIViewController {
    let disposeBag = DisposeBag()
    
    lazy var customTabbar = CustomNavigatorBar(frame: CGRect(x: 0, y: 0, width: ScreenW, height: NAVBAR_HEIGHT)).then {
        $0.backgroundColor = .white
        $0.postBackAction {[weak self] in
            self?.lz_popViewController(animated: true)
        }
    }
    
    
    var hiddenTopBar:Bool = false{
        didSet{
            customTabbar.isHidden=hiddenTopBar
        }
    }
    
    var titleInfo:String = ""{
        didSet{
            customTabbar.titleInfo=titleInfo
        }
    }
    
    var hiddenBackButton:Bool = false{
        didSet{
            customTabbar.hiddenBackButton=hiddenBackButton
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(customTabbar)
    }
    
    //是否需要登录
    open func lz_pushViewControllerWithNeedLogin(viewController: UIViewController) -> Void {
        lz_pushViewController(viewController: viewController)
    }
    
    ///压入栈
    open func lz_pushViewController(viewController: UIViewController) -> Void {
        if (navigationController?.viewControllers.count ?? 0) > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @objc func goBack() {
        lz_popViewController(animated: true)
    }
    
    ///是否隐藏navagatorBar
    open func lz_NavigatorType(withBool bool:Bool)  {
        self.navigationController?.setNavigationBarHidden(bool, animated: false)
    }
    
    ///退出栈
    open func lz_popViewController(animated: Bool) -> Void {
        _ = self.navigationController?.popViewController(animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable=true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ToastView.instance.clear()
        self.view.endEditing(true)
    }
    
    ///是否顶部半透明
    open func isOpenNavigatorTranslucent(withBool flag:Bool)  {
         self.navigationController?.navigationBar.isTranslucent = flag
    }
    
    deinit {
        ToastView.instance.clear()
        NSLog("\(self.classForCoder)已释放")
        NotificationCenter.default.removeObserver(self)
    }
}


class CustomNavigatorBar: UIView {
    
    /// 返回按钮
    private lazy var backButton = UIButton().then {
        $0.setImage(UIImage(named: "返回-1"), for: .normal)
        $0.imageView?.size=CGSize(width: 10, height: 18)
        $0.rx.tap.subscribe(onNext: {[weak self] () in
            self?.backAction?()
        }).disposed(by: disposeBag)
        self.addSubview($0)
    }
    
    /// 右侧按钮
    lazy var rightSaveButton = UIButton().then {
        $0.setTitleColor(UIColor.RGB(r: 60, g: 60, b: 60), for: .normal)
        $0.setTitle("保存", for: .normal)
        $0.titleLabel?.font=UIFont(name: "PingFangTC-Semibold", size: 18)
        $0.contentMode = .left
        $0.isHidden=true
        $0.rx.tap.subscribe(onNext: { [weak self]() in
            self?.rightAction?()
        }).disposed(by: disposeBag)
        self.addSubview($0)
        $0.contentHorizontalAlignment = .right
    }
    
    /// 标题头
    lazy var titleLabel = UILabel().then {
        $0.font=UIFont(name: "PingFangTC-Semibold", size: 16)
        $0.textColor = UIColor.RGB(r: 8, g: 8, b: 8)
        $0.textAlignment = .center
        
        self.addSubview($0)
        
    }
    
    
    var titleInfo:String = ""{
        didSet{
            titleLabel.text=titleInfo
        }
    }
    
    private let disposeBag = DisposeBag()
    private var backAction:(()->())?
    func postBackAction(withBlock block:(()->())?)  {
        backAction=block
    }
    private var rightAction:(()->())?
    func postRightAction(withBlock block:(()->())?)  {
        rightAction=block
    }

    var rightButtonInfo:String = ""{
        didSet{
            rightSaveButton.setTitle(rightButtonInfo, for: .normal)
        }
    }
    
    var hiddenRightButton:Bool = false{
        didSet{
            rightSaveButton.isHidden=hiddenRightButton
        }
    }
    
    var hiddenBackButton:Bool = false{
        didSet{
            backButton.isHidden=hiddenBackButton
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backButton.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(60*PionWidth)
            make.right.equalToSuperview().offset(-60*PionWidth)
            make.height.equalTo(titleLabel.snp.height)
            make.centerY.equalTo(backButton.snp.centerY)
        }
        rightSaveButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-2)
            make.right.equalToSuperview().offset(-18)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
