//
//  AppDelegate.swift
//  within1000m
//
//  Created by 徐永宏 on 2018/3/8.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let naviCon = UINavigationController(rootViewController: MapViewController())
        naviCon.isNavigationBarHidden = true
        window?.rootViewController = naviCon
        
        window?.makeKeyAndVisible()
        
        return true
    }


}

