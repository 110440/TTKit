//
//  CGPoint+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/23.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint{
    
    func GetDistanceToPoint(point:CGPoint)->Float{
        let xx = (self.x - point.x) * (self.x - point.x)
        let yy = (self.y - point.y) * (self.y - point.y)
        return sqrt(Float( xx + yy ) )
    }
    
    var pixelAlignedFloor:CGPoint{
        get{
            let x = self.x.float.pixelAlignedFloor
            let y = self.y.float.pixelAlignedFloor
            return CGPointMake(x.cgFloat,y.cgFloat)
        }
    }
    var pixelAlignedRound:CGPoint{
        get{
            let x = self.x.float.pixelAlignedRound
            let y = self.y.float.pixelAlignedRound
            return CGPointMake(x.cgFloat, y.cgFloat)
        }
    }
    var pixelAlignedCeil:CGPoint{
        get{
            let x = self.x.float.pixelAlignedCeil
            let y = self.y.float.pixelAlignedCeil
            return CGPointMake(x.cgFloat, y.cgFloat)
        }
    }
    var pixelAlignedHalf:CGPoint{
        get{
            let x = self.x.float.pixelAlignedHalf
            let y = self.y.float.pixelAlignedHalf
            return CGPointMake(x.cgFloat, y.cgFloat)
        }
    }
    
}