//
//  User.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/25.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginResponse: Mappable {
    var aUser: userBean?
    
    var beginTime: String?
    var endTime: String?
    var success: Bool?
    
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        aUser  <- map["userbean"]
        beginTime  <- map["beginTime"]
        endTime     <- map["endTime"]
        success    <- map["success"]
    }
}

class userBean: Mappable {
    var staffRole: String?
    var staffGroup: String?
    var staffName: String?
    var staffId: String?
    
    required init?(_ map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        staffRole  <- map["staffRole"]
        staffGroup     <- map["staffGroup"]
        staffName    <- map["staffName"]
        staffId    <- map["staffId"]
    }
}
