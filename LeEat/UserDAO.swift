//
//  UserDAO.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/26.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class UserDAO: NSObject {
    class func isLogin() -> Bool {
        let aId = Defaults[.userStaffId]
        if aId.characters.count > 0 {
            return true
        }
        return false
    }

    class func logout() {
        Defaults[.userStaffId] = ""
        Defaults[.userStaffName] = ""
        Defaults[.userStaffGroup] = ""
        Defaults[.userStaffRole] =  ""
        Defaults[.userGroupId] = ""
    }

}
