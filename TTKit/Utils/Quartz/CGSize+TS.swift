//
//  CGSize+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/24.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension CGSize{
    
    
    var pixelAlignedFloor:CGSize{
        get{
            let w = self.width.float.pixelAlignedFloor
            let h = self.height.float.pixelAlignedFloor
            return CGSize(width: w.cgFloat, height: h.cgFloat)
        }
    }
    var pixelAlignedRound:CGSize{
        get{
            let w = self.width.float.pixelAlignedRound
            let h = self.height.float.pixelAlignedRound
            return CGSize(width: w.cgFloat, height: h.cgFloat)
        }
    }
    var pixelAlignedCeil:CGSize{
        get{
            let w = self.width.float.pixelAlignedCeil
            let h = self.height.float.pixelAlignedCeil
            return CGSize(width: w.cgFloat, height: h.cgFloat)
        }
    }
    var pixelAlignedHalf:CGSize{
        get{
            let w = self.width.float.pixelAlignedCeil
            let h = self.height.float.pixelAlignedCeil
            return CGSize(width: w.cgFloat, height: h.cgFloat)
        }
    }
}