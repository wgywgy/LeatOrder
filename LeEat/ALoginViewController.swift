//
//  ViewController.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/25.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit
import ObjectMapper
import AnimatedTextInput
import JDropDownAlert

class ALoginViewController: BaseViewController {
    
    @IBOutlet weak var userIDInput: AnimatedTextInput!
    @IBOutlet weak var passwdInput: AnimatedTextInput!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIDInput.placeHolderText = "员工ID"
        userIDInput.type = .numeric
        passwdInput.placeHolderText = "密码"
        passwdInput.type = .password
        
        self.title = "乐饭团"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Done, target: self, action: #selector(touchLoginBtn(_:)))
    }
    
    func touchLoginBtn(sender: AnyObject) {
        let aVc = OrderDetailViewController()
        self.navigationController?.pushViewController(aVc, animated: true)
        return
            
        print("userId: \(userIDInput.text)")
        print("userwd: \(passwdInput.text)")
        guard let txt = userIDInput.text, userId = Int(txt) else {
            userIDInput.show(error: "输入错误!", placeholderText: "员工ID")
            return
        }
        
        guard let passwd = passwdInput.text else {
            passwdInput.show(error: "输入错误!", placeholderText: "密码")
            return
        }
        
        guard passwd.characters.count > 0 else {
            passwdInput.show(error: "输入错误!", placeholderText: "密码")
            return
        }
        
        loginAction(userId: userId, passwd: passwd)
    }
    
    func loginAction(userId id: Int, passwd: String) {
        LeEatProvider.request(.Login(id, passwd)) { (result) in
            switch result {
            case let .Success(response):
                let json = String(data: response.data, encoding: NSUTF8StringEncoding)
                let user = Mapper<LoginResponse>().map(json)
                print("user: \(user?.success)")
                
                if user?.success == true {
                    // Save UserInfo
                    let aVc = OrderDetailViewController()
                    self.navigationController?.pushViewController(aVc, animated: true)
                } else {
                    let alert = JDropDownAlert()
                    alert.alertWith("登录失败")
                }
            case let .Failure(error):
                print("err: \(error)")
                let alert = JDropDownAlert()
                alert.alertWith("登录失败")
            }
        }
    }
}

