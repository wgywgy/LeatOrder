//
//  CanBookResponse.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/26.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import Foundation
import ObjectMapper

class CanBookResponse: Mappable {
    var staffId: String?
    var timeBook: Bool?
    var hasBook: Bool?
    
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        staffId  <- map["staffId"]
        timeBook <- map["timeBook"]
        hasBook  <- map["hasBook"]
    }
}

