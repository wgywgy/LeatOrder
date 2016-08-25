//
//  OrderDetailViewController.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/25.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

class OrderDetailViewController: BaseViewController {

    let lookUpGroupBtn: UIButton = {
        let aBtn = UIButton(type: .Custom)
        aBtn.setTitle("查看本组订餐成员", forState: .Normal)
        return aBtn
    }()
    
    let customSwitch: CustomSwitch = {
        let aSwitch = CustomSwitch()
        aSwitch.backgroundColor = UIColor.clearColor()
        aSwitch.layer.cornerRadius = 8.0
        return aSwitch
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "乐饭团"
        
        customSwitch.frame = CGRectMake(40.0, (ScreenSize.height / 2) - 87.0, ScreenSize.width - 80.0, 84)
        self.view.addSubview(customSwitch)

        lookUpGroupBtn.frame = CGRect(x: 0, y: 100, width: 200, height: 40)
        lookUpGroupBtn.addTarget(self, action: #selector(touchLookGroupBtn), forControlEvents: .TouchUpInside)
        self.view.addSubview(lookUpGroupBtn)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出登录", style: UIBarButtonItemStyle.Done, target: self, action: #selector(touchLogoutBtn(_:)))
    }
    
    func touchLookGroupBtn() {
        let aVC = GroupListViewController(nibName: "GroupListViewController", bundle: nil)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    func touchLogoutBtn(sender: AnyObject) {
        // Clean Local Save
        
        self.navigationController?.popViewControllerAnimated(true)
    }

}
