//
//  NSNotificationCenter+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/21.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation

extension NSNotificationCenter{
    
    class func postNotificationOnMainThread(name:String,obj:AnyObject){
        if pthread_main_np() != 0 {
            return self.defaultCenter().postNotificationName(name, object: obj)
        }
        self.postNotificationOnMainThread(name, obj: obj, info: NSDictionary())
    }
    
    class func postNotificationOnMainThread(name:String,obj:AnyObject,info:NSDictionary){
        if pthread_main_np() != 0 {
            return self.defaultCenter().postNotificationName(name, object: obj, userInfo: info as [NSObject : AnyObject])
        }
        self.postNotificationOnMainThread(name, obj: obj, info: info, waitUntilDone: false)
    }
    
    class func postNotificationOnMainThread(name:String,obj:AnyObject,info:NSDictionary,waitUntilDone:Bool){
        if pthread_main_np() != 0 {
            return self.defaultCenter().postNotificationName(name, object: obj, userInfo: info as [NSObject : AnyObject])
        }
        let dic = NSMutableDictionary(capacity: 3)
        dic.setObject(name, forKey: "name")
        dic.setObject(obj, forKey: "obj")
        dic.setObject(info, forKey: "info")
        self.performSelectorOnMainThread("_ts_posNotification:", withObject: dic, waitUntilDone: waitUntilDone)
    }
    
    @objc
    class private func _ts_posNotification(info:NSDictionary){
        let name = info.objectForKey("name") as! String
        let obj = info.objectForKey("obj")
        let userInfo = info.objectForKey("info") as! NSDictionary
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: obj, userInfo: userInfo as [NSObject : AnyObject] )
    }
}