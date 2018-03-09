//
//  PopupWindow.swift
//  within1000m
//
//  Created by 徐永宏 on 2018/3/8.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class PopupWindow: NSObject {
    
    static func popAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

}
