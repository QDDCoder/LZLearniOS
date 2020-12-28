//
//  LZCustomSearchView.swift
//  QKYC
//
//  Created by 七颗牙 on 2019/2/21.
//  Copyright © 2019 zhan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class LZCustomSearchView: UIView {

    
    private var clickSearch:(()->())?
    
    ///搜索bar
    private lazy var searchBar: UISearchBar = {
        let searchBar=UISearchBar(frame: CGRect(x: 0, y: (frame.size.height-30)/2, width: frame.size.width-52*PionWidth, height: 30))
        searchBar.backgroundImage=UIImage()
        searchBar.returnKeyType = .search
        
        searchBar.placeholder="请输入搜索内容"
        let searchTextField = searchBar.value(forKey: "searchField") as? UITextField
        if searchTextField != nil {
            searchTextField!.backgroundColor=UIColor.RGB(r: 245, g: 245, b: 245)
            searchTextField!.frame=searchBar.bounds
            searchTextField!.layer.cornerRadius=19
            searchTextField!.textAlignment = .left
            searchTextField!.font=UIFont.systemFont(ofSize: 14)
            searchTextField!.layer.masksToBounds=true
        }
        
        return searchBar
    }()
    

    
    
    private lazy var searchButton: UIButton = {
        let searchButton=UIButton(frame: CGRect.zero)
        searchButton.setTitle("搜索", for: .normal)
        searchButton.setTitleColor(UIColor.RGB(r: 2, g: 2, b: 2), for: .normal)
        searchButton.addAction {[weak self] in
            self?.clickSearch?()
        }
        return searchButton
    }()
    

    
    private let disposeBag = DisposeBag()
    
    func postClickSearchAction(withAction action:(()->())?)  {
        clickSearch=action
    }
    
    func getSearchInfo() -> String {
        return searchBar.text ?? ""
    }
    
    //code
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(searchBar)
        self.addSubview(searchButton)
        
        searchButton.snp.makeConstraints { (make) in
            make.left.equalTo(searchBar.snp.right)
            make.height.equalTo(PionHeight*26)
            make.width.equalTo(45*PionWidth)
            make.centerY.equalTo(searchBar.snp.centerY)
        }
    }
    
   
    
    //xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func layoutSubviews() {
       super.layoutSubviews()
    }
    ///自定义self.navigationItem.titleView 是必须重写
    override open var intrinsicContentSize: CGSize {
        get {
            return self.size
        }
    }
}
