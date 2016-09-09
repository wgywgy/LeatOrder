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
import SwiftyUserDefaults

class ALoginViewController: BaseViewController {

    @IBOutlet weak var userIDInput: AnimatedTextInput!
    @IBOutlet weak var passwdInput: AnimatedTextInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        userIDInput.placeHolderText = "员工ID"
        userIDInput.type = .numeric
        userIDInput.backgroundColor = UIColor.clearColor()
        passwdInput.placeHolderText = "密码"
        passwdInput.type = .password
        passwdInput.backgroundColor = UIColor.clearColor()

        self.title = "乐饭团"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Done, target: self, action: #selector(touchLoginBtn(_:)))

        if UserDAO.isLogin() {
            self.navigationController?.pushViewController(OrderDetailViewController(), animated: false)
        }

    }

    func touchLoginBtn(sender: AnyObject) {
//        let aVc = OrderDetailViewController()
//        self.navigationController?.pushViewController(aVc, animated: true)
//        return

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
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        indicator.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)

        LeEatProvider.request(.Login(id, passwd)) { (result) in
            switch result {

            case let .Success(response):
                self.navigationItem.rightBarButtonItem =
                    UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ALoginViewController.touchLoginBtn(_:)))
                let json = String(data: response.data, encoding: NSUTF8StringEncoding)
                let user = Mapper<LoginResponse>().map(json)
                print("user: \(user?.success)")

                if user?.success == true {
                    // Save UserInfo
                    Defaults[.userStaffId] = user?.aUser?.staffId ?? ""
                    Defaults[.userStaffName] = user?.aUser?.staffName ?? ""
                    Defaults[.userStaffGroup] = user?.aUser?.staffGroup ?? ""
                    Defaults[.userStaffRole] = user?.aUser?.staffRole ?? ""
                    Defaults[.userGroupId] = user?.aUser?.groupId ?? ""

                    let aId = Defaults[.userStaffId]
                    print("aId: \(aId)")

                    let aVc = OrderDetailViewController()
                    self.navigationController?.pushViewController(aVc, animated: true)
                } else {
                    let alert = JDropDownAlert()
                    alert.alertWith("登录失败")
                }
            case let .Failure(error):
                print("err: \(error)")
                self.navigationItem.rightBarButtonItem =
                    UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ALoginViewController.touchLoginBtn(_:)))

                let alert = JDropDownAlert()
                alert.alertWith("登录失败")
            }
        }
    }
}
