//
//  UIEdgeInsets+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/24.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension UIEdgeInsets{
    
    var pixelAlignedFloor:UIEdgeInsets{
        get{
            let top = self.top.float.pixelAlignedFloor
            let left = self.left.float.pixelAlignedFloor
            let bottom = self.bottom.float.pixelAlignedFloor
            let right = self.right.float.pixelAlignedFloor
            
            return UIEdgeInsets(top: top.cgFloat, left: left.cgFloat, bottom: bottom.cgFloat, right: right.cgFloat)
        }
    }

    var pixelAlignedCeil:UIEdgeInsets{
        get{
            let top = self.top.float.pixelAlignedCeil
            let left = self.left.float.pixelAlignedCeil
            let bottom = self.bottom.float.pixelAlignedCeil
            let right = self.right.float.pixelAlignedCeil
            
            return UIEdgeInsets(top: top.cgFloat, left: left.cgFloat, bottom: bottom.cgFloat, right: right.cgFloat)
        }
    }
    
}