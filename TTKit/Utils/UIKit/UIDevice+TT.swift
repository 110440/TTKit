//
//  UIDevice+TT.swift
//  TTKit
//
//  Created by tanson on 16/3/13.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

private let _tt_systemVersion = Double(UIDevice.currentDevice().systemVersion)

extension UIDevice {
    
    static var systemVersionInDouble:Double?{
        return _tt_systemVersion
    }
        
    static var isJailbroken:Bool{
        let paths = [
            "/Applications/Cydia.app",
            "/private/var/lib/apt/",
            "/private/var/lib/cydia",
            "/private/var/stash"
            ]
        for path in paths{
            if NSFileManager.defaultManager().fileExistsAtPath(path) {return true}
        }
        
        if let _ = NSFileHandle(forReadingAtPath: "/bin/bash") {
            return true
        }
        
        let path = "/private/" +  NSString.striingWithUUID()
        do{
            try ("test" as NSString).writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
            try NSFileManager.defaultManager().removeItemAtPath(path)
            return true
        } catch{
        }
        return false
    }
    
    static var diskSpace:Int64{
        do{
            let attrs = try NSFileManager.defaultManager().attributesOfFileSystemForPath(NSHomeDirectory())
            if let space = attrs[NSFileSystemSize] as? NSNumber {
                return space.longLongValue
            }
            return -1
        }catch{
            return -1
        }
    }
    
    static var diskSpaceFree:Int64{
        do{
            let attrs = try NSFileManager.defaultManager().attributesOfFileSystemForPath(NSHomeDirectory())
            if let space = attrs[NSFileSystemFreeSize] as? NSNumber {
                return space.longLongValue
            }
            return -1
        }catch{
            return -1
        }
    }
    
    static var diskSpaceUsed:Int64{
        let total = self.diskSpace
        let free  = self.diskSpaceFree
        if total <= 0 || free <= 0{
            return -1
        }
        let used = total - free
        if used < 0 {
            return -1
        }
        return used
    }

}