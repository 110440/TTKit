//
//  NSString+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/22.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension NSString{
    
    func sizeForFont(var font:UIFont?,size:CGSize,lineBreakMode:NSLineBreakMode)->CGSize{
        if font == nil {
            font = UIFont.systemFontOfSize(12)
        }
        var attr = [String:AnyObject]()
        attr[NSFontAttributeName] = font
        if lineBreakMode != NSLineBreakMode.ByWordWrapping{
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode
            attr[NSParagraphStyleAttributeName] = paragraphStyle
        }
        let rect = self.boundingRectWithSize(size, options: [.UsesLineFragmentOrigin,.UsesFontLeading], attributes: attr, context: nil)
        return rect.size
    }
    
    func widthForFont(font:UIFont)->Float{
        let size = self.sizeForFont(font, size: CGSize(width:CGFloat(HUGE), height:CGFloat(HUGE) ), lineBreakMode: NSLineBreakMode.ByWordWrapping)
        return Float(size.width)
    }
    func heightForFont(font:UIFont,width:Float)->Float{
        let size = self.sizeForFont(font, size: CGSize(width: CGFloat(width), height: CGFloat(HUGE) ), lineBreakMode: NSLineBreakMode.ByWordWrapping)
        return Float(size.height)
    }
    
    func matchesRegex(pattern:String)->Bool{
        do{
            let regex = try NSRegularExpression(pattern: pattern,options: .CaseInsensitive)
            let number =  regex.numberOfMatchesInString(self as String, options: [], range: NSMakeRange(0, self.length))
            return number > 0
        }catch{
            return false
        }
    }

    //MARK 
    var isEmail:Bool{
        get{
            let pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            return self.matchesRegex(pattern)
        }
    }
    
    var isSite:Bool{
        get{
            let pattern = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
            return self.matchesRegex(pattern)
        }
    }
    
    var isPhoneNumber:Bool{
        get{
            let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
            let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
            let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
            let CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
            return self.matchesRegex(mobile) || self.matchesRegex(CM) || self.matchesRegex(CU) || self.matchesRegex(CT)
        }
    }
    
    func isContainsString(string:String)->Bool{
        return self.rangeOfString(string).location != NSNotFound
    }
    
    class func striingWithUUID()->String{
        let uuid = CFUUIDCreate(nil)
        let string = CFUUIDCreateString(nil, uuid)
        return string as String
    }
    
}


