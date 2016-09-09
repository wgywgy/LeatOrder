//
//  OrderDetailViewController.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/25.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit
import ObjectMapper
import JDropDownAlert
import SwiftyUserDefaults
import RAMPaperSwitch
import Firebase
import GoogleMobileAds

class OrderDetailViewController: BaseViewController {

    let adId = "ca-app-pub-6052474397535297/3610219767"

    let lookUpGroupBtn: UIButton = {
        let aBtn = UIButton(type: .Custom)
        aBtn.setTitle("查看本组订餐成员", forState: .Normal)
        return aBtn
    }()

    var paperSwitch1: RAMPaperSwitch?
    var paperSwitch2: RAMPaperSwitch?

    let orderLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.text = "是否订餐"
        aLabel.textColor = UIColor(hex: 0x1FB7FC)
        return aLabel
    }()

    let rssLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.text = "是否每日推送订餐消息"
        aLabel.textColor = UIColor(hex: 0x8EC63F)
        return aLabel
    }()

    let aBgView = UIView()
    let aBgView2 = UIView()

    let bannerView = GADBannerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.whiteColor()

        self.title = "乐饭团"

        lookUpGroupBtn.frame = CGRect(x: 30, y: 100, width: ScreenSize.width - 60, height: 40)
        lookUpGroupBtn.addTarget(self, action: #selector(touchLookGroupBtn), forControlEvents: .TouchUpInside)
        lookUpGroupBtn.backgroundColor = UIColor.defaultTintColor()
        lookUpGroupBtn.layer.cornerRadius = 20
        lookUpGroupBtn.layer.masksToBounds = true
        self.view.addSubview(lookUpGroupBtn)

        let adBarHeight: CGFloat = 50

        bannerView.frame = CGRect(x: 0, y: ScreenSize.height - 50, width: ScreenSize.width, height: 50)
        bannerView.adUnitID = "ca-app-pub-6052474397535297/1800140966"
        bannerView.rootViewController = self

        self.view.addSubview(bannerView)
        let request = GADRequest()
        bannerView.loadRequest(request)

        let bgViewHeight = (ScreenSize.height - adBarHeight - 174) / 2

        aBgView.frame = CGRect(x: 0, y: 174, width: ScreenSize.width, height: bgViewHeight)
        self.view.addSubview(aBgView)

        aBgView2.frame = CGRect(x: 0, y: aBgView.frame.size.height + aBgView.frame.origin.y, width: ScreenSize.width, height: bgViewHeight)
        self.view.addSubview(aBgView2)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出登录", style: UIBarButtonItemStyle.Done, target: self, action: #selector(touchLogoutBtn(_:)))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

        LeEatProvider.request(.CanBook) { (result) in
            switch result {
            case let .Success(response):
                let json = String(data: response.data, encoding: NSUTF8StringEncoding)
                let response = Mapper<CanBookResponse>().map(json)
                print("response: \(response?.hasBook) b: \(response?.timeBook)")
                if response?.hasBook == true {
                    self.paperSwitch1?.setOn(true, animated: true)
                }

            case let .Failure(error):
                print("err: \(error)")
            }
        }

        setupPaperSwitch()
    }

    func setupPaperSwitch() {
        orderLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        aBgView.addSubview(orderLabel)
        orderLabel.center = CGPoint(x: 210, y: aBgView.frame.size.height / 2)

        paperSwitch1 = RAMPaperSwitch(view: aBgView, color: UIColor(hex: 0x1FB7FC))
        paperSwitch1?.center = CGPoint(x: aBgView.frame.size.width - 60, y: aBgView.frame.size.height / 2)
        aBgView.addSubview(paperSwitch1!)
        paperSwitch1!.animationDidStartClosure = {(onAnimation: Bool) in
            self.animateLabel(self.orderLabel, onAnimation: onAnimation, color: UIColor(hex: 0x1FB7FC), duration: self.paperSwitch1!.duration)
        }

        paperSwitch1?.addTarget(self, action: #selector(switchOne), forControlEvents: .TouchUpInside)

        rssLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        aBgView2.addSubview(rssLabel)
        rssLabel.center = CGPoint(x: 154, y: aBgView2.frame.size.height / 2)

        paperSwitch2 = RAMPaperSwitch(view: aBgView2, color: UIColor(hex: 0x8EC63F))
        paperSwitch2?.center = CGPoint(x: aBgView2.frame.size.width - 60, y: aBgView2.frame.size.height / 2)
        aBgView2.addSubview(paperSwitch2!)
        paperSwitch2?.addTarget(self, action: #selector(switchTwo), forControlEvents: .TouchUpInside)

        paperSwitch2!.animationDidStartClosure = {(onAnimation: Bool) in
            self.animateLabel(self.rssLabel, onAnimation: onAnimation, color: UIColor(hex: 0x8EC63F), duration: self.paperSwitch2!.duration)
        }

        if NotifyHelper.sharedInstance.isScribe {
            paperSwitch2?.setOn(true, animated: true)
        }
    }

    func switchOne() {
        guard let paperSwitch1 = paperSwitch1 else { return }
        if paperSwitch1.on {
            print("On switch")
            // 订餐
            LeEatProvider.request(.CanBook) { (result) in
                switch result {
                case let .Success(response):
                    let json = String(data: response.data, encoding: NSUTF8StringEncoding)
                    let response = Mapper<CanBookResponse>().map(json)
                    print("response: \(response?.hasBook) b: \(response?.timeBook)")
                    if response?.timeBook == false {
                        let alert = JDropDownAlert()
                        alert.alertWith("不能订餐： 已经错过订餐时间")
                    } else {
                        self.orderFood()
                    }

                case let .Failure(error):
                    print("err: \(error)")
                    let alert = JDropDownAlert()
                    alert.alertWith("不能订餐： 网络错误")
                }
            }

        } else {
            print("Off switch")
            // 不订餐
            LeEatProvider.request(.Delete) { (result) in
                switch result {
                case let .Success(response):
                    let json = String(data: response.data, encoding: NSUTF8StringEncoding)
                    print("json: \(json)")
                case let .Failure(error):
                    print("err: \(error)")
                    let alert = JDropDownAlert()
                    alert.alertWith("不能取消订餐： 网络错误")
                }
            }
        }
    }

    func switchTwo() {

        //注册通知：
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)

        guard let paperSwitch2 = paperSwitch2 else { return }
        if paperSwitch2.on {
            NotifyHelper.sharedInstance.startNotify()
        } else {
            NotifyHelper.sharedInstance.cancelNotify()
        }
    }


    func orderFood() {
        LeEatProvider.request(.Book) { (result) in
            switch result {
            case let .Success(response):
                let json = String(data: response.data, encoding: NSUTF8StringEncoding)
                let response = Mapper<BookResponse>().map(json)

                // Save Order Date
                Defaults[.orderDate] = response?.orderDate ?? ""
            case let .Failure(error):
                print("err: \(error)")
                let alert = JDropDownAlert()
                alert.alertWith("不能订餐： 网络错误")
            }
        }
    }

    func touchLookGroupBtn() {
        let aVC = GroupListViewController(nibName: "GroupListViewController", bundle: nil)
        self.navigationController?.pushViewController(aVC, animated: true)
    }

    func touchLogoutBtn(sender: AnyObject) {
        // Clean Local Save
        UserDAO.logout()

        self.navigationController?.popViewControllerAnimated(true)
    }

    private func animateLabel(label: UILabel, onAnimation: Bool, color: UIColor, duration: NSTimeInterval) {
        UIView.transitionWithView(label, duration: duration, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            label.textColor = onAnimation ? UIColor.whiteColor() : color
            }, completion:nil)
    }

}
