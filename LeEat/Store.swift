//
//  Store.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/26.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let userStaffId = DefaultsKey<String>("userStaffId")
    static let userStaffRole = DefaultsKey<String>("userStaffRole")
    static let userStaffGroup = DefaultsKey<String>("userStaffGroup")
    static let userStaffName = DefaultsKey<String>("userStaffName")
    static let userGroupId = DefaultsKey<String>("userGroupId")
    static let orderDate = DefaultsKey<String>("orderDate")
    static let isTurnOnNotify = DefaultsKey<Bool>("isTurnOnNotify")
}
