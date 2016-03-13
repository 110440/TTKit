//
//  UIScreen+TT.swift
//  TTKit
//
//  Created by tanson on 16/3/13.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension UIScreen{
    
    static var screenScale:Float{
        struct g {
            static var screenScale:Float = 0
            static var onceToken:dispatch_once_t = 0
        }
        
        dispatch_once(&g.onceToken) { () -> Void in
            if NSThread.isMainThread(){
                g.screenScale = UIScreen.mainScreen().scale.float
            }else{
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    g.screenScale = UIScreen.mainScreen().scale.float
                })
            }
        }
        return g.screenScale
    }
}