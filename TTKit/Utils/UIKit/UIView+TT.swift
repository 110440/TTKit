//
//  UIView+TT.swift
//  TTKit
//
//  Created by tanson on 16/3/13.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func snapshotImage()->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0)
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
    }

    func snapshotImageAfterScreenUpdates(b:Bool)->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0)
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: b)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
    }
    
    func setLayerShadow(color:UIColor , offset:CGSize , radius:Float){
        self.layer.shadowColor = color.CGColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius.cgFloat
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    var viewController:UIViewController?{
        var view:UIView? = self
        while let v = view {
            if let nextResponder = v.nextResponder(){
                if let controller = nextResponder as? UIViewController {
                    return controller
                }
            }
            view = v.superview
        }
        return nil
    }
    
    var left:Float{
        return self.frame.origin.x.float
    }
    
    var top:Float{
        return self.frame.origin.y.float
    }

    var right:Float{
        return self.left + self.width
    }
    
    var bottom:Float{
        return self.top + self.height
    }
    
    var width:Float{
        return self.frame.size.width.float
    }
    
    var height:Float{
        return self.frame.size.height.float
    }
    
    var centerX:Float{
        return self.center.x.float
    }
    var centerY:Float{
        return self.center.y.float
    }
 
    var size:CGSize{
        return self.frame.size
    }
    
    var origin:CGPoint{
        return self.frame.origin
    }

}

extension UIView {
    
    class func fromNib<T : UIView>(nibNameOrNil: String? = nil) -> T {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            name = "\(T.self)".componentsSeparatedByString(".").last!
        }
        let nibViews = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews {
            if let tog = v as? T {
                view = tog
            }
        }
        return view!
    }
}