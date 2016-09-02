//
//  NotifyHelper.swift
//  LeEat
//
//  Created by wuguanyu on 16/8/26.
//  Copyright © 2016年 wuguanyu. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

private let kLocalNotificationMessage:String = "该订餐了！"
private let kLocalNotificationTimeInterval:NSTimeInterval = 8

class NotifyHelper: NSObject {
    
    static let sharedInstance = NotifyHelper()
    
    var isScribe = false
    override init() {
        isScribe = Defaults[.isTurnOnNotify]
    }
    
    func startNotify() {
        isScribe = true
        Defaults[.isTurnOnNotify] = isScribe
        scheduleLocalNotificationIfPossible()
    }
    
    func cancelNotify() {
        isScribe = false
        Defaults[.isTurnOnNotify] = isScribe
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func alarmDate() -> NSDate {
        let date: NSDate = NSDate()
        let cal: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let newDate: NSDate = cal.dateBySettingHour(14, minute: 30, second: 0, ofDate: date, options: NSCalendarOptions())!

        return newDate
    }
    
    private func localNotification() -> UILocalNotification {
        let localNotification = UILocalNotification()
        localNotification.fireDate = alarmDate()
        
        localNotification.repeatInterval = NSCalendarUnit.Day
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = kLocalNotificationMessage
        return localNotification
    }
    
    private func scheduleLocalNotificationIfPossible() {
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification())
    }

}