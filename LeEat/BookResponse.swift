//
//  File.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/26.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import Foundation
import ObjectMapper

class BookResponse: Mappable {
    var success: Bool?
    var orderDate: String?
    
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        success  <- map["success"]
        orderDate <- map["orderDate"]
    }
}
