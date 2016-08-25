//
//  LeEatAPI.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/25.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit
import Moya

let baseAddress = "http://10.58.104.151:8080"
class LeEatAPI: NSObject {

}

private func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

let LeEatProvider =
    MoyaProvider<LeEat>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

public enum LeEat {
    case Login(Int, String)
    case CanBook
    case Book
}

extension LeEat: TargetType {
    public var baseURL: NSURL { return NSURL(string: baseAddress)! }
    public var path: String {
        switch self {
        case .Login:
            return "/lebookdinner/login"
        case .CanBook:
            return "/lebookdinner/canbok"
        case .Book:
            return "/lebookdinner/book"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case Login, CanBook, Book:
            return .GET
        }
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case Login(let userId, let passwd):
            return ["userId": userId, "password": passwd]
        case CanBook:
            return ["":""]
        case Book:
            return ["":""]
        }
    }
    
    public var multipartBody: [Moya.MultipartFormData]? {
        return nil
    }
    
    public var sampleData: NSData {
        return "sampleData".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}