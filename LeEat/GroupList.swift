//
//  GroupList.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/26.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import Foundation

import ObjectMapper

class GroupListResponse: Mappable {
    var groupList: [GroupList]?
    var success: Bool?
    required init?(_ map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        groupList  <- map["groupList"]
        success    <- map["success"]
    }
}

class GroupList: Mappable {
    
    var staffName: String?
    var staffId: String?
    var staffRole: String?
    var staffGroup: String?
    
    required init?(_ map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        staffName  <- map["staffName"]
        staffId  <- map["staffId"]
        staffRole     <- map["staffRole"]
        staffGroup    <- map["staffGroup"]
    }
}