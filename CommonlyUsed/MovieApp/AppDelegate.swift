//
//  AppDelegate.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxDataSources
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds);
        self.window?.rootViewController = LZNavigationController(rootViewController: LZBaseHomeVC())
        self.window?.makeKeyAndVisible()
        return true
    }
}

