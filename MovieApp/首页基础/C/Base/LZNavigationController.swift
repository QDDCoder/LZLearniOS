//
//  LZNavigationController.swift
//  sdxf
//
//  Created by 湛亚磊 on 2020/1/9.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class LZNavigationController: UINavigationController,UINavigationControllerDelegate {
    var popDelegate: UIGestureRecognizerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigatorBar()
        setPopGestureRecognizer()
        
    }
    //设置 手势返回
    func setPopGestureRecognizer()  {
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }
    
    //设置顶部bar的颜色
    private func setNavigatorBar()  {
//        self.view.backgroundColor = UIColor.white
//        self.navigationBar.shadowImage=UIImage.image(withColor: UIColor.white, size: CGSize(width: ScreenW, height: 1))
//        self.navigationBar.backgroundColor=UIColor.white
//        self.navigationBar.isTranslucent=false
//        self.navigationBar.layer.shadowOffset=CGSize(width: 0, height: 2)
//        self.navigationBar.layer.shadowColor=UIColor.RGB(r: 164, g: 163, b: 163)?.cgColor
//        self.navigationBar.layer.shadowOpacity=0.39
//        self.navigationBar.clipsToBounds=false
    }

}

// MARK: - UINavigationControllerDelegate方法
extension LZNavigationController{
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        }
        else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
    }
}
