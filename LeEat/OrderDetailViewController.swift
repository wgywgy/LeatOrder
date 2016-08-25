//
//  OrderDetailViewController.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/25.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

class OrderDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "乐饭团"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出登录", style: UIBarButtonItemStyle.Done, target: self, action: #selector(touchLogoutBtn(_:)))
    }
    
    func touchLogoutBtn(sender: AnyObject) {
        // Clean Local Save
        
        self.navigationController?.popViewControllerAnimated(true)
    }

}
