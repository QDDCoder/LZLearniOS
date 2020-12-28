//
//  UIImageView+Extension.swift
//  Feicui
//
//  Created by people on 2018/6/9.
//  Copyright © 2018年 zhan. All rights reserved.
//

import UIKit

extension UIImageView {
//    func getImageWithUrl(withUrlString url:String?,withIcon normalIconImage:UIImage=normalImage,withISCache isCache:Bool=true)  {
//        weak var weakSelf=self
//        if url != "" && url != nil {
//            if let url = URL(string: url!){
//                self.af_setImage(withURL:url, placeholderImage: normalIconImage,imageTransition: .crossDissolve(0.4), runImageTransitionIfCached: isCache) { (data) in
//                    data.result.ifSuccess {
//                        if data.data != nil{
//                            //因为有缓存 所以不会请求 网络
//                            weakSelf?.image=UIImage(data: data.data!)
//                        }
//                    }
//                    data.result.ifFailure {
//                        weakSelf?.image=normalIconImage
//                    }
//                }
//            }
//        }else{
//            self.image=normalIconImage
//        }
//    }
    func cutImageView(withCornRadius radius:CGFloat)  {
        self.layer.cornerRadius=radius
        self.layer.masksToBounds=true
    }
//    func getImageWithUrlWithGif(withUrlString url:String?)  {
//        weak var weakSelf=self
//        let tempNormalImage = UIImage.gif(asset: "loading")
//        
//        if url != "" && url != nil {
//            self.af_setImage(withURL: URL(string: url!)!, placeholderImage: tempNormalImage,imageTransition: .crossDissolve(0.4), runImageTransitionIfCached: true) { (data) in
//                data.result.ifSuccess {
//                    if data.data != nil{
//                        //因为有缓存 所以不会请求 网络
//                        weakSelf?.image=UIImage(data: data.data!)
//                    }
//                }
//                data.result.ifFailure {
//                    weakSelf?.image=tempNormalImage
//                }
//            }
//        }else{
//            self.image=tempNormalImage
//        }
//    }

    
}
