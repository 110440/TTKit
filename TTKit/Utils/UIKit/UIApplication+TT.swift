//
//  UIApplication+TT.swift
//  TTKit
//
//  Created by tanson on 16/3/13.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication{
    
    static var documentsURL:NSURL?{
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last
    }
    static var documentsPath:String?{
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
    }
    
    static var cachesURL:NSURL?{
        return NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).last
    }
    static var cachesPath:String?{
        return NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first
    }
    
    static var libraryURL:NSURL?{
        return NSFileManager.defaultManager().URLsForDirectory(.LibraryDirectory, inDomains: .UserDomainMask).last
    }
    static var libraryPath:String?{
        return NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true).first
    }
    
    static var tempURL:NSURL?{
        return NSURL(string: NSTemporaryDirectory())
    }
    static var tempPath:String?{
        return NSTemporaryDirectory()
    }
    
    static var appBundleName:String?{
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as? String
    }
    
    static var appBundleID:String?{
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleIdentifier") as? String
    }
    
    static var appVersion:String?{
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String
    }
    
    static var appBuildVersion:String?{
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") as? String
    }
    
}