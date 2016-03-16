//
//  localNotify.swift
//  TTKit
//
//  Created by tanson on 16/3/16.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension UILocalNotification {
    
    public class func registerUserNotificationSettings(){
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert,.Badge,.Sound], categories: nil ))
    }
    
    // 每天的固暄时间点触发一个本地通知
    public class func fireLocalNotifycationAtHour(hour:Int){
    
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        let localNotifycation = UILocalNotification()
        let now = NSDate()
        
        // 计算出今天要触发通知的时间点
        let conponent = NSCalendar.currentCalendar().components([.Year,.Month,.Day], fromDate: now)
        let fireDateStr = "\(conponent.year)-\(conponent.month)-\(conponent.day)-\(hour)-0-0"
        let fireDateformatter = NSDateFormatter()
        fireDateformatter.dateFormat = "YYYY-MM-dd-HH-mm-ss"
        let fireDate = fireDateformatter.dateFromString(fireDateStr)
        
        //比较触发时间是否已经过了，是的话推迟明天
        if now.timeIntervalSinceDate(fireDate!) > 0{
            //明天
            let tomorrowFireDate = fireDate!.dateByAddingTimeInterval(24 * 60 * 60 )
            localNotifycation.fireDate = tomorrowFireDate
        }else{
            localNotifycation.fireDate = fireDate
        }
        localNotifycation.repeatInterval = NSCalendarUnit.Day
        localNotifycation.timeZone = NSTimeZone.defaultTimeZone()
        localNotifycation.applicationIconBadgeNumber = 1
        localNotifycation.alertBody = "这是一个本地通知"
        localNotifycation.alertAction = "打开查看"
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotifycation)
    }
    
}
