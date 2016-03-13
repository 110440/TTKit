//
//  CALayer+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/23.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension CALayer{
    
    func takeSnapshotImage()->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0)
        let context = UIGraphicsGetCurrentContext()
        self.renderInContext(context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func setLayerShadow(color:UIColor,offset:CGSize,radius:Float){
        self.shadowColor = color.CGColor
        self.shadowOffset = offset
        self.shadowRadius = CGFloat(radius)
        self.shadowOpacity = 1
        self.shouldRasterize = true
        self.rasterizationScale = UIScreen.mainScreen().scale
    }

    func removeAllSublayers(){
        if let sublayers = self.sublayers{
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    
    //MARK 
    
    var left:Float{
        get{
            return Float(self.frame.origin.x)
        }
        set{
            var frame = self.frame
            frame.origin.x = CGFloat(newValue)
            self.frame = frame
        }
    }
    
    var top:Float{
        get{
            return Float(self.frame.origin.y)
        }
        set{
            var frame = self.frame
            frame.origin.y = CGFloat(newValue)
            self.frame = frame
        }
    }
    
    var right:Float{
        get{
            return Float(self.frame.origin.x + self.frame.size.width)
        }
        set{
            var frame = self.frame
            frame.origin.x = CGFloat(newValue) - frame.size.width
            self.frame = frame
        }
    }
    
    var bottom:Float{
        get{
            return Float(self.frame.origin.y + self.frame.size.height)
        }
        set{
            var frame = self.frame
            frame.origin.y = CGFloat(newValue) - frame.size.height
            self.frame = frame
        }
    }
    
    var width:Float{
        get{
            return Float(self.frame.size.width)
        }
        set{
            var frame = self.frame
            frame.size.width = CGFloat(newValue)
            self.frame = frame
        }
    }
    
    var height:Float{
        get{
            return Float(self.frame.size.height)
        }
        set{
            var frame = self.frame
            frame.size.height = CGFloat(newValue)
            self.frame = frame
        }
    }
    
    var center:CGPoint{
        get{
            let frame = self.frame
            return CGPoint(x: frame.origin.x+frame.size.width*0.5, y: frame.origin.y+frame.size.height*0.5)
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue.x - frame.size.width*0.5
            frame.origin.y = newValue.y - frame.size.height*0.5
            self.frame = frame
        }
    }
    
    var centerX:Float{
        get{
            return Float(self.frame.origin.x + self.frame.size.width*0.5)
        }
        set{
            var frame = self.frame
            frame.origin.x = CGFloat(newValue) - frame.size.width*0.5
            self.frame = frame
        }
    }
    
    var centerY:Float{
        get{
            return Float(self.frame.origin.y + self.frame.size.height*0.5)
        }
        set{
            var frame = self.frame
            frame.origin.y = CGFloat(newValue) - frame.size.height*0.5
            self.frame = frame
        }
    }
    
    var origin:CGPoint{
        get{
            return self.frame.origin
        }
        set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var frameSize:CGSize{
        get{
            return self.frame.size
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    var transformRotation:Float{
        get{
            let v = self.valueForKeyPath("transform.rotation")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.rotation")
        }
    }
    
    var transformRotationX:Float{
        get{
            let v = self.valueForKeyPath("transform.rotation.x")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.rotation.x")
        }
    }
    
    var transformRotationY:Float{
        get{
            let v = self.valueForKeyPath("transform.rotation.y")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.rotation.y")
        }
    }
    
    var transformRotationZ:Float{
        get{
            let v = self.valueForKeyPath("transform.rotation.z")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.rotation.z")
        }
    }
    
    var transformScale:Float{
        get{
            let v = self.valueForKeyPath("transform.scale")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.scale")
        }
    }
    
    var transformScaleX:Float{
        get{
            let v = self.valueForKeyPath("transform.scale.x")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.scale.x")
        }
    }
    
    var transformScaleY:Float{
        get{
            let v = self.valueForKeyPath("transform.scale.y")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.scale.y")
        }
    }
    
    var transformScaleZ:Float{
        get{
            let v = self.valueForKeyPath("transform.scale.z")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.scale.z")
        }
    }
    
    var transformTranslationX:Float{
        get{
            let v = self.valueForKeyPath("transform.translation.x")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.translation.x")
        }
    }
    
    var transformTranslationY:Float{
        get{
            let v = self.valueForKeyPath("transform.translation.y")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.translation.y")
        }
    }
    
    var transformTranslationZ:Float{
        get{
            let v = self.valueForKeyPath("transform.translation.z")
            return (v as! NSNumber).floatValue
        }
        set{
            self.setValue(NSNumber(float: newValue), forKeyPath: "transform.translation.z")
        }
    }
    
    var transformDepth:Float{
        get{
            return Float(self.transform.m34)
        }
        set{
            var d = self.transform
            d.m34 = CGFloat(newValue)
            self.transform = d
        }
    }

    var contentMode:UIViewContentMode{
        get{
            switch self.contentsGravity{
            case kCAGravityCenter:
                return .Center
            case kCAGravityTop:
                return .Top
            case kCAGravityBottom:
                return .Bottom
            case kCAGravityLeft:
                return .Left
            case kCAGravityRight:
                return .Right
            case kCAGravityTopLeft:
                return .TopLeft
            case kCAGravityTopRight:
                return .TopRight
            case kCAGravityBottomLeft:
                return .BottomLeft
            case kCAGravityBottomRight:
                return .BottomRight
            case kCAGravityResize:
                return .ScaleToFill
            case kCAGravityResizeAspect:
                return .ScaleAspectFit
            case kCAGravityResizeAspectFill:
                return .ScaleToFill
            default:
                return .Center
            }
        }
        set{
            var mode:String? = nil
            switch newValue {
            case .ScaleToFill: mode = kCAGravityResize
            case .ScaleAspectFit: mode = kCAGravityResizeAspect
            case .ScaleAspectFill: mode = kCAGravityResizeAspectFill
            case .Redraw: mode = kCAGravityResize
            case .Center: mode = kCAGravityCenter
            case .Top: mode = kCAGravityTop
            case .Bottom: mode = kCAGravityBottom
            case .Left: mode = kCAGravityLeft
            case .Right: mode = kCAGravityRight
            case .TopLeft: mode = kCAGravityTopLeft
            case .TopRight: mode = kCAGravityTopRight
            case .BottomLeft: mode = kCAGravityBottomLeft
            case .BottomRight: mode = kCAGravityBottomRight
            }
            
            if let _mode = mode{
                self.contentsGravity = _mode
            }
        }
    }
    
    //MARK animation
    func addFadeAnimationWithDuration(duration:NSTimeInterval,curve:UIViewAnimationCurve){
        if duration <= 0 {return}
        
        var mediaFunction:String? = nil
        
        switch curve{
        case .EaseInOut: mediaFunction = kCAMediaTimingFunctionEaseInEaseOut
        case .EaseIn: mediaFunction = kCAMediaTimingFunctionEaseIn
        case .EaseOut: mediaFunction = kCAMediaTimingFunctionEaseOut
        case .Linear: mediaFunction = kCAMediaTimingFunctionLinear
        }
        
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: mediaFunction!)
        transition.type = kCATransitionFade
        self.addAnimation(transition, forKey: "TS.fade")
    }

    func removePreviousFadeAnimation(){
        self.removeAnimationForKey("TS.fade")
    }

    
}