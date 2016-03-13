//
//  NSDictionary+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/21.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation

extension NSDictionary{
    
    class func dictionaryWithPlistData(data:NSData)->NSDictionary?{
        do{
            let dic = try NSPropertyListSerialization.propertyListWithData(data, options: .Immutable, format: nil)
            return dic as? NSDictionary
        }catch{
            return nil
        }
    }
    
    class func dictionaryWithPlistString(string:String)->NSDictionary?{
        let data = string.dataUsingEncoding(NSUTF8StringEncoding)
        return self.dictionaryWithPlistData(data!)
    }
    
    //MARK - sort
    var allKeysSorted:NSArray{
        get{
            let keys = self.allKeys as NSArray
            return keys.sortedArrayUsingSelector("caseInsensitiveCompare:")
        }
    }
    
    var allValuesSortedByKeys:NSArray{
        get{
            let sortedKeys = self.allKeysSorted
            let arr = NSMutableArray()
            for key in sortedKeys{
                arr.addObject(self.objectForKey(key)!)
            }
            return arr
        }
    }
    
    
    //MARK -
    var plistData:NSData? {
        get{
            do{
                let data = try NSPropertyListSerialization.dataWithPropertyList(self, format: .BinaryFormat_v1_0, options:0)
                return data
            }catch{
                return nil
            }
        }
    }
    var plistString:NSString?{
        get{
            do{
                let xmlData = try NSPropertyListSerialization.dataWithPropertyList(self, format: .XMLFormat_v1_0, options: 0)
                return NSString(data: xmlData, encoding: NSUTF8StringEncoding)
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