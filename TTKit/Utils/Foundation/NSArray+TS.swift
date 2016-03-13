//
//  NSArray+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/21.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation

extension NSArray {
    
    class func arrayWithPlistData(data:NSData)->NSArray?{
        
        do{
            let array = try NSPropertyListSerialization.propertyListWithData(data, options: .Immutable, format: nil)
            return array as? NSArray
        }catch{
            return nil
        }
    }
    
    class func arrayWithPlistString(string:String)->NSArray?{
        let data = string.dataUsingEncoding(NSUTF8StringEncoding)
        return self.arrayWithPlistData(data!)
    }
    
    class func arrayWithJsonString(string:String)->NSArray?{
        do{
            let data = string.dataUsingEncoding(NSUTF8StringEncoding)
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            return json as? NSArray
        }catch{
            return nil
        }
    }
    
    //MARK --
    var plistData:NSData?{
        get{
            do{
                let data = try NSPropertyListSerialization.dataWithPropertyList(self, format: .BinaryFormat_v1_0, options:0 )
                return data
            }catch{
                return nil
            }
        }
    }
    
    var jsonString:NSString?{
        get{
            if NSJSONSerialization.isValidJSONObject(self){
                do{
                    let jsonData = try NSJSONSerialization.dataWithJSONObject(self, options:[])
                    return NSString(data: jsonData, encoding: NSUTF8StringEncoding)
                }catch{
                    return nil
                }
            }
            return nil
        }
    }
    
    var jsonPrettyString:NSString?{
        get{
            if NSJSONSerialization.isValidJSONObject(self){
                do{
                    let jsonData = try NSJSONSerialization.dataWithJSONObject(self, options: NSJSONWritingOptions.PrettyPrinted)
                    return NSString(data: jsonData, encoding: NSUTF8StringEncoding)
                }catch{
                    return nil
                }
            }
            return nil
        }
    }
}
