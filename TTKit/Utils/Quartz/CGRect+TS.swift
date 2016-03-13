//
//  CGRect+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/23.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension CGRect{
    
    var center:CGPoint{
        get{
            return CGPoint(x: self.midX, y: self.midY )
        }
    }
    
    var area:Float{
        get{
            if self.isNull {return 0}
            let rect = self.standardized
            return Float(rect.size.width * rect.size.height)
        }
    }
    
    var pixelAlignedFloor:CGRect{
        get{
            let origin = self.origin.pixelAlignedFloor
            let corner = CGPoint(x: self.origin.x + self.size.width, y: self.origin.y + self.size.height).pixelAlignedFloor
            var rect = CGRect(x: origin.x, y: origin.y, width: corner.x - origin.x, height: corner.y - origin.y)
            if rect.size.width < 0 { rect.size.width = 0 }
            if rect.size.height < 0 { rect.size.height = 0 }
            return rect
        }
    }
    var pixelAlignedRound:CGRect{
        get{
            let origin = self.origin.pixelAlignedRound
            let corner = CGPoint(x: self.origin.x + self.size.width, y: self.origin.y + self.size.height).pixelAlignedRound
            let rect = CGRect(x: origin.x, y: origin.y, width: corner.x - origin.x, height: corner.y - origin.y)
            return rect
        }
    }
    var pixelAlignedCeil:CGRect{
        get{
            let origin = self.origin.pixelAlignedCeil
            let corner = CGPoint(x: self.origin.x + self.size.width, y: self.origin.y + self.size.height).pixelAlignedCeil
            let rect = CGRect(x: origin.x, y: origin.y, width: corner.x - origin.x, height: corner.y - origin.y)
            return rect
        }
    }
    var pixelAlignedHalf:CGRect{
        get{
            let origin = self.origin.pixelAlignedHalf
            let corner = CGPoint(x: self.origin.x + self.size.width, y: self.origin.y + self.size.height).pixelAlignedHalf
            let rect = CGRect(x: origin.x, y: origin.y, width: corner.x - origin.x, height: corner.y - origin.y)
            return rect
        }
    }
}