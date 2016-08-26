//
//  GroupListViewController.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/25.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit
import JDropDownAlert
import ObjectMapper

class GroupListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var groupList = [GroupList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "乐饭团"
        tableView.dataSource = self
        tableView.delegate = self
        getData()
    }
    
    deinit {
        print("deinit")
    }

    func getData() {
        LeEatProvider.request(.GroupList) { (result) in
            switch result {
                
            case let .Success(response):
                let json = String(data: response.data, encoding: NSUTF8StringEncoding)
                let response = Mapper<GroupListResponse>().map(json)
                
                if let groupList = response?.groupList {
                    self.groupList = groupList
                    self.tableView.reloadData()
                }
                
            case let .Failure(error):
                print("err: \(error)")
                let alert = JDropDownAlert()
                alert.alertWith("登录失败")
            }
        }

        
        self.tableView.reloadData()
    }
}

extension GroupListViewController: UITableViewDelegate {
    
}

extension GroupListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCellWithIdentifier("aCell") ?? UITableViewCell(style: .Default, reuseIdentifier: "aCell")
        let aData = groupList[indexPath.row]
        
        if let id = aData.staffId, staffName = aData.staffName {
            aCell.textLabel?.text = staffName + " " + id
        }
        aCell.detailTextLabel?.text  = aData.staffGroup
        return aCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList.count
    }
}
