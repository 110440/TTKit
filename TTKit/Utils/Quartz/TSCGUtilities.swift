//
//  TSCGUtilities.swift
//  TSKit
//
//  Created by tanson on 16/1/23.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

func TSCGContextCreateARGBBitmapContext(size:CGSize,opaque:Bool,scale:Float)->CGContextRef?{
    let width = ceil(size.width * CGFloat(scale))
    let height = ceil(size.height * CGFloat(scale))
    if width < 1 || height < 1 {return nil}
    
    //pre-multiplied ARGB, 8-bits per component
    let space = CGColorSpaceCreateDeviceRGB()
    let alphaInfo = opaque ? CGImageAlphaInfo.NoneSkipFirst : CGImageAlphaInfo.PremultipliedFirst
    let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.ByteOrderDefault.rawValue | alphaInfo.rawValue )
    let context = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, space,bitmapInfo.rawValue)
    if let ct = context {
        CGContextTranslateCTM(ct, 0, height)
        CGContextScaleCTM(ct, CGFloat(scale), CGFloat(-scale))
    }
    return context
}

func TSCGContextCreateGrayBitmapContext(size:CGSize,scale:Float)->CGContextRef?{
    
    let width = ceil(size.width * CGFloat(scale))
    let height = ceil(size.height * CGFloat(scale))
    if width < 1 || height < 1 {return nil}
    
    //pre-multiplied ARGB, 8-bits per component
    let space = CGColorSpaceCreateDeviceGray()
    let alphaInfo = CGImageAlphaInfo.None
    let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.ByteOrderDefault.rawValue | alphaInfo.rawValue )
    let context = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, space,bitmapInfo.rawValue)
    if let ct = context {
        CGContextTranslateCTM(ct, 0, height)
        CGContextScaleCTM(ct, CGFloat(scale), CGFloat(-scale))
    }
    return context
}

var TSScreenScale:Float {
    get{
        return Float(UIScreen.mainScreen().scale)
    }
}

var TSScreenSize:CGSize{
    get{
        var size = UIScreen.mainScreen().bounds.size
        if size.height < size.width{
            let temp = size.height
            size.height = size.width
            size.width = temp
        }
        return size
    }
}

func TSCGRectFitWithContentMode(var rect:CGRect,var size:CGSize,mode:UIViewContentMode)->CGRect{
    
    rect = CGRectStandardize(rect)
    size.width = size.width < 0 ? -size.width : size.width;
    size.height = size.height < 0 ? -size.height : size.height;
    let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
    
    switch (mode) {
    case .ScaleAspectFit,.ScaleAspectFill:
        
        if rect.size.width < 0.01 || rect.size.height < 0.01 || size.width < 0.01 || size.height < 0.01 {
                rect.origin = center;
                rect.size = CGSizeZero;
        } else {
            var scale:CGFloat
            
            if (size.width / size.height < rect.size.width / rect.size.height) && (mode == .ScaleAspectFit) {
                    scale = rect.size.height / size.height
            } else {
                scale = rect.size.width / size.width
            }
            size.width *= scale
            size.height *= scale
            rect.size = size
            rect.origin = CGPointMake(center.x - size.width * 0.5, center.y - size.height * 0.5)
        }

    case .Center:
        rect.size = size;
        rect.origin = CGPointMake(center.x - size.width * 0.5, center.y - size.height * 0.5)
    case .Top:
        rect.origin.x = center.x - size.width * 0.5
        rect.size = size

    case .Bottom:
        rect.origin.x = center.x - size.width * 0.5
        rect.origin.y += rect.size.height - size.height
        rect.size = size

    case .Left:
        rect.origin.y = center.y - size.height * 0.5
        rect.size = size

    case .Right:
        rect.origin.y = center.y - size.height * 0.5
        rect.origin.x += rect.size.width - size.width
        rect.size = size

    case .TopLeft:
        rect.size = size

    case .TopRight:
        rect.origin.x += rect.size.width - size.width
        rect.size = size

    case .BottomLeft:
        rect.origin.y += rect.size.height - size.height
        rect.size = size

    case .BottomRight:
        rect.origin.x += rect.size.width - size.width
        rect.origin.y += rect.size.height - size.height
        rect.size = size

//    case .ScaleAspectFill,.Redraw:
//        break
    default:
        break
    }
    return rect
}

func getDistanceFromPoint(point:CGPoint,var toRect:CGRect)->Float{
    toRect = toRect.standardized
    if toRect.contains(point) {return 0 }
    var distV:CGFloat
    var distH:CGFloat
    
    if toRect.minY <= point.y && point.y <= toRect.maxY {
        distV = 0
    }else{
        distV = point.y < toRect.minY ? toRect.minY - point.y : point.y - toRect.maxY
    }
    if toRect.minX <= point.x && point.x <= toRect.maxX{
        distH = 0
    }else{
        distH = point.x < toRect.minX ? toRect.minX - point.x : point.x - toRect.maxX
    }
    return max(distV.float, distH.float)
}

