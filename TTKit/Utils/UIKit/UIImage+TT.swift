//
//  UIImage+TT.swift
//  TTKit
//
//  Created by tanson on 16/3/13.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit
import ImageIO
import Accelerate


extension UIImage{
    
    class func imageWithColor(color:UIColor)->UIImage{
        return self.imageWithColor(color, size: CGSize(width: 1, height: 1))!
    }
    
    class func imageWithColor(color:UIColor,size:CGSize)->UIImage?{
        
        if (size.width <= 0 || size.height <= 0) {return nil}
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func imageWithSize(size:CGSize ,drawBlock:(context:CGContextRef)->Void) ->UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size,false, 0)
        guard let context = UIGraphicsGetCurrentContext() else{return nil}
        drawBlock(context: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func hasAlphaChannel()->Bool{
        if self.CGImage == nil {return false}
        let alpha = CGImageGetAlphaInfo(self.CGImage).rawValue & CGBitmapInfo.AlphaInfoMask.rawValue
        return (alpha == CGImageAlphaInfo.First.rawValue ||
            alpha == CGImageAlphaInfo.Last.rawValue ||
            alpha == CGImageAlphaInfo.PremultipliedFirst.rawValue ||
            alpha == CGImageAlphaInfo.PremultipliedLast.rawValue)
    }

    func drawInRect(rect:CGRect , withContentMode:UIViewContentMode , clipsToBounds:Bool){
    
        let drawRect = TSCGRectFitWithContentMode(rect, size: self.size, mode: withContentMode)
        if (drawRect.size.width == 0 || drawRect.size.height == 0) {return}
        if clipsToBounds {
            
            if let context = UIGraphicsGetCurrentContext() {
                CGContextSaveGState(context)
                CGContextAddRect(context,rect)
                CGContextClip(context)
                self.drawInRect(drawRect)
                CGContextRestoreGState(context)
            }
        } else {
            self.drawInRect(drawRect)
        }

    }
    
    func imageByResizeToSize(size:CGSize)->UIImage?{
        if (size.width <= 0 || size.height <= 0) {return nil}
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageByResizeToSize(size:CGSize,contentMode:UIViewContentMode)->UIImage?{
        if (size.width <= 0 || size.height <= 0) {return nil}
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height), withContentMode: contentMode, clipsToBounds:false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageByCropToRect(var rect:CGRect)->UIImage?{
        rect.origin.x *= self.scale
        rect.origin.y *= self.scale
        rect.size.width *= self.scale
        rect.size.height *= self.scale
        if (rect.size.width <= 0 || rect.size.height <= 0) {return nil}
        if let imageRef = CGImageCreateWithImageInRect(self.CGImage, rect){
            return UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        }
        return nil
    }
    
    //图片加边框
    func imageByAddInsetEdge(insets:UIEdgeInsets , color:UIColor?)->UIImage?{
        var size = self.size
        size.width -= (insets.left + insets.right)
        size.height -= (insets.top + insets.bottom)
        if (size.width <= 0 || size.height <= 0) {return nil}
        let rect = CGRect(x: -insets.left, y: -insets.top, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        if let color = color {
            CGContextSetFillColorWithColor(context, color.CGColor)
            let path = CGPathCreateMutable()
            CGPathAddRect(path, nil, CGRectMake(0, 0, size.width, size.height))
            CGPathAddRect(path, nil, rect)
            CGContextAddPath(context, path)
            CGContextEOFillPath(context)
        }
        self.drawInRect(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // 圆角
    func imageByRoundCornerRadius(radius:Float)->UIImage?{
        return self.imageByRoundCornerRadius(radius, borderW: 0, borderColor: nil)
    }
    
    func imageByRoundCornerRadius(radius:Float,borderW:Float,borderColor:UIColor?)->UIImage?{
        return self.imageByRoundCornerRadius(radius, corners: UIRectCorner.AllCorners, borderW: borderW, borderColor: borderColor, borderLineJoin: CGLineJoin.Miter)
    }
    
    func imageByRoundCornerRadius(radius:Float, corners:UIRectCorner,borderW:Float,borderColor:UIColor?,borderLineJoin:CGLineJoin)->UIImage?{
        
        var corners = corners
        if (corners != UIRectCorner.AllCorners) {
            var tmp:UInt = 0
            if (corners.rawValue & UIRectCorner.TopLeft.rawValue) > 0 { tmp |= UIRectCorner.TopLeft.rawValue }
            if (corners.rawValue & UIRectCorner.TopRight.rawValue) > 0 { tmp |= UIRectCorner.TopRight.rawValue }
            if (corners.rawValue & UIRectCorner.BottomLeft.rawValue) > 0 { tmp |= UIRectCorner.BottomLeft.rawValue }
            if (corners.rawValue & UIRectCorner.BottomRight.rawValue) > 0 { tmp |= UIRectCorner.BottomRight.rawValue }
            corners = UIRectCorner(rawValue: tmp)
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextScaleCTM(context, 1, -1)
        CGContextTranslateCTM(context, 0, -rect.size.height)
        
        let minSize = min(self.size.width, self.size.height)
        
        if (borderW.cgFloat < minSize / 2) {
            let path = UIBezierPath(roundedRect: CGRectInset(rect, borderW.cgFloat, borderW.cgFloat), byRoundingCorners: corners, cornerRadii: CGSize(width: radius.cgFloat, height: borderW.cgFloat))
            path.closePath()
            CGContextSaveGState(context)
            path.addClip()
            CGContextDrawImage(context, rect, self.CGImage)
            CGContextRestoreGState(context)
        }
        
        if let borderColor = borderColor where (borderW.cgFloat < minSize / 2) && borderW > 0 {
            
            let strokeInset = (floor(borderW.cgFloat * self.scale) + 0.5) / self.scale
            let strokeRect = CGRectInset(rect, strokeInset, strokeInset)
            let strokeRadius = radius.cgFloat > self.scale / 2 ? radius.cgFloat - self.scale / 2 : 0
            let path = UIBezierPath(roundedRect: strokeRect, byRoundingCorners: corners, cornerRadii: CGSize(width: strokeRadius, height: borderW.cgFloat))
            path.closePath()
            
            path.lineWidth = borderW.cgFloat
            path.lineJoinStyle = borderLineJoin
            borderColor.setStroke()
            path.stroke()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    private func _tt_flipHorizontal(horizontal:Bool , vertical:Bool)->UIImage?{
        if self.CGImage == nil {return nil}
        let width = CGImageGetWidth(self.CGImage)
        let height = CGImageGetHeight(self.CGImage)
        let bytesPerRow = width * 4
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let ct = CGBitmapContextCreate(nil , width, height, 8, bytesPerRow, colorSpace, CGBitmapInfo.ByteOrderDefault.rawValue|CGImageAlphaInfo.PremultipliedFirst.rawValue)
        
        guard let context = ct else {return nil}
        
        CGContextDrawImage(context, CGRect(x: 0, y: 0, width: width, height: height), self.CGImage)
        let data = CGBitmapContextGetData(context)
        
        if data == nil {
            return nil
        }
        
        let src  = vImage_Buffer(data: data,height: UInt(height),width: UInt(width),rowBytes: bytesPerRow)
        let dest = vImage_Buffer(data: data,height: UInt(height),width: UInt(width),rowBytes: bytesPerRow)

        if vertical {
            let src = unsafeBitCast(src, UnsafePointer<vImage_Buffer>.self)
            let dest = unsafeBitCast(dest, UnsafePointer<vImage_Buffer>.self)
            vImageVerticalReflect_ARGB8888(src,dest,UInt32(kvImageBackgroundColorFill) )
        }
        if horizontal {
            let src = unsafeBitCast(src, UnsafePointer<vImage_Buffer>.self)
            let dest = unsafeBitCast(dest, UnsafePointer<vImage_Buffer>.self)
            vImageHorizontalReflect_ARGB8888(src,dest,UInt32(kvImageBackgroundColorFill) )
        }
        if let imgRef = CGBitmapContextCreateImage(context){
            let img = UIImage(CGImage: imgRef, scale: self.scale, orientation: self.imageOrientation)
            return img
        }
        return nil
    }
    
    func imageByRotate180()->UIImage?{
        return self._tt_flipHorizontal(true, vertical: true)
    }
    
    func imageByFlipVertical()->UIImage?{
        return self._tt_flipHorizontal(false, vertical: true)
    }
    
    func imageByFlipHorizontal()->UIImage?{
        return self._tt_flipHorizontal(true, vertical: false)
    }
    
    func imageByTintColor(color:UIColor)->UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        color.set()
        UIRectFill(rect)
        self.drawAtPoint(CGPoint(x: 0, y: 0), blendMode: CGBlendMode.DestinationIn, alpha: 1)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}