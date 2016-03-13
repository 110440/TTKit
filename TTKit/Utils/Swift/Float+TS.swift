//
//  Float+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/24.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension  Float{
    
    //MARK CG Helper
    
    var cgFloat:CGFloat{
        get{
            return CGFloat(self)
        }
    }
    
    var pixelValue:Float{
        get{
            return self * TSScreenScale
        }
    }
    
    var pointValue:Float{
        get{
            return self / TSScreenScale
        }
    }
    
    var pixelAlignedFloor:Float{
        get{
            return floor(self * TSScreenScale) / TSScreenScale
        }
    }
    var pixelAlignedRound:Float{
        get{
            return round(self * TSScreenScale) / TSScreenScale
        }
    }
    var pixelAlignedCeil:Float{
        get{
            return ceil(self * TSScreenScale) / TSScreenScale
        }
    }
    var pixelAlignedHalf:Float{
        get{
            return (floor(self * TSScreenScale) + 0.5) / TSScreenScale
        }
    }
}

extension CGFloat{
    var float:Float{
        get{
            return Float(self)
        }
    }
}