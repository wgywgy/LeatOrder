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

class ViewController: UIViewController {

    @IBOutlet weak var passwdInput: AnimatedTextInput!
    @IBOutlet weak var userIDInput: AnimatedTextInput!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIDInput.placeHolderText = "员工ID"
        passwdInput.placeHolderText = "密码"
        passwdInput.type = .password
        
    }
    
    @IBAction func touchLoginBtn(sender: AnyObject) {
        print("userId: \(userIDInput.text)")
        print("userwd: \(passwdInput.text)")
        loginAction(userId: userIDInput.text, passwd: passwdInput.text)
    }
    
    func loginAction(userId id: String?, passwd: String?) {
        LeEatProvider.request(.Login(123456, 123456)) { (result) in
            switch result {
            case let .Success(response):
                let data = response.data
                let json = String(data: data, encoding: NSUTF8StringEncoding)
                let user = Mapper<LoginResponse>().map(json)
                print("user: \(user?.success)")
            case let .Failure(error):
                print("err: \(error)")
            }
        }
    }
}

