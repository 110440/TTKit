//
//  NSDate+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/21.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation

extension NSDate{
    
    var year:Int {
        get{
            return NSCalendar.currentCalendar().components(.Year, fromDate: self).year
        }
    }
    
    var month:Int {
        get{
            return NSCalendar.currentCalendar().components(.Month, fromDate: self).month
        }
    }
    
    var day:Int {
        get{
            return NSCalendar.currentCalendar().components(.Day, fromDate: self).day
        }
    }
    
    var hour:Int{
        get{
            return NSCalendar.currentCalendar().components(.Hour, fromDate: self).hour
        }
    }
    
    var minute:Int{
        get{
            return NSCalendar.currentCalendar().components(.Minute, fromDate: self).minute
        }
    }
    
    var second:Int{
        get{
            return NSCalendar.currentCalendar().components(.Second, fromDate: self).second
        }
    }
    
    var nanosecond:Int{
        get{
            return NSCalendar.currentCalendar().components(.Nanosecond, fromDate: self).nanosecond
        }
    }
    
    var weekday:Int{
        get{
            return NSCalendar.currentCalendar().components(.Weekday, fromDate: self).weekday
        }
    }
    
    var weekdayOrdinal:Int{
        get{
            return NSCalendar.currentCalendar().components(.WeekdayOrdinal, fromDate: self).weekdayOrdinal
        }
    }
    var weekOfMonth:Int{
        get{
            return NSCalendar.currentCalendar().components(.WeekOfMonth, fromDate: self).weekOfMonth
        }
    }
    var weekOfYear:Int{
        get{
            return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: self).weekOfYear
        }
    }
    var yearForWeekOfYear:Int{
        get{
            return NSCalendar.currentCalendar().components(.YearForWeekOfYear, fromDate: self).yearForWeekOfYear
        }
    }
    var quarter:Int{
        get{
            return NSCalendar.currentCalendar().components(.Quarter, fromDate: self).quarter
        }
    }
    var isLeapMonth:Bool{
        get{
            return NSCalendar.currentCalendar().components(.Quarter, fromDate: self).leapMonth
        }
    }
    var isLeapYear:Bool{
        get{
            let year = self.year
            return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0) ) )
        }
    }
    
    var isToday:Bool{
        get{
            if ( fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24 ) { return false }
            return NSDate().day == self.day
        }
    }
    
    var  isYesterday:Bool{
        get{
            let added = self.dateByAddingDays(1)
            return added.isToday
        }
    }
    
    // MARK -- fun
    
    func dateByAddingYears(years:Int)->NSDate?{
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.year = years
        return calendar.dateByAddingComponents(components, toDate: self, options: [])
    }
    
    func dateByAddingMonths(months:Int)->NSDate?{
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.month = months
        return calendar.dateByAddingComponents(components, toDate: self, options: [])
    }
    
    func dateByAddingWeeks(weeks:Int)->NSDate?{
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.weekday = weeks
        return calendar.dateByAddingComponents(components, toDate: self, options: [])
    }
    
    func dateByAddingDays(days:Int)->NSDate{
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(86400 * days)
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }

    func dateByAddingHours(hours:Int)->NSDate{
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(3600 * hours)
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    func dateByAddingMinutes(minutes:Int)->NSDate{
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(60 * minutes)
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    func dateByAddingSeconds(seconds:Int)->NSDate{
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(seconds)
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    // MARK -- string
    
    func stringWithFormat(format:String)->String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromDate(self)
    }
    
    func stringWithFormat(format:String,timeZone:NSTimeZone,locale:NSLocale)->String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.stringFromDate(self)
    }
    
    func stringWithISOFormat()->String{
        
        struct g{
            static var formatter:NSDateFormatter? = nil
            static var onceToken:dispatch_once_t = 0
        }
        dispatch_once(&g.onceToken){
            g.formatter = NSDateFormatter()
            g.formatter?.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            g.formatter?.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        return (g.formatter?.stringFromDate(self))!
    }
    
    func stringInRange()->String{
        
        var localDateString = self.stringWithISOFormat()

        var distance = NSDate().timeIntervalSinceDate(self)
        
        if distance < 0 { distance = 0 }
        
        if distance < 60 {
            localDateString = "\(Int(distance))秒前"
        }
        else if (distance < 60 * 60) {
            distance = distance / 60
            localDateString = "\(Int(distance))分钟前"
        }
        else if (distance < 60 * 60 * 24) {
            distance = distance / 60 / 60
            localDateString = "\(Int(distance))小时前"
        }
        else if (distance < 60 * 60 * 24 * 7) {
            distance = distance / 60 / 60 / 24
            localDateString = "\(Int(distance))天前"
        }
        
        return localDateString
    }
    
    //MARK - class func
    
    class func dateWithString(dateString:String,format:String)->NSDate?{
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.dateFromString(dateString)
    }
    
    class func dateWithString(dateString:String,format:String,timezone:NSTimeZone,locale:NSLocale)->NSDate?{
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timezone
        formatter.locale = locale
        return formatter.dateFromString(dateString)
    }

    class func dateWithISOFormatString(dateString:String)->NSDate{
        struct g{
            static var formatter:NSDateFormatter? = nil
            static var onceToken:dispatch_once_t = 0
        }
        dispatch_once(&g.onceToken){
            g.formatter = NSDateFormatter()
            g.formatter?.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            g.formatter?.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        return (g.formatter?.dateFromString(dateString))!
    }
  
    
}