//
//  Defines.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/25.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import UIKit

struct ScreenSize
{
    static let width = UIScreen.mainScreen().bounds.size.width
    static let height = UIScreen.mainScreen().bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}
