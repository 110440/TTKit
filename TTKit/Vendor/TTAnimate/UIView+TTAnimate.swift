//
//  UIView+TTAnimate.swift
//  Demo
//
//  Created by tanson on 16/3/15.
//  Copyright © 2016年 miqu. All rights reserved.
//

import Foundation
import UIKit


internal func degreesToRadians(degree: CGFloat) -> CGFloat {
    return (degree / 180.0) * CGFloat(M_PI)
}

//MARK:- UIView  动画扩展
extension UIView{
    
    public func transformToIdentity(){
        self.transform = CGAffineTransformIdentity
    }
    
    public func moveToX(x:CGFloat){
        let distance = x - self.frame.origin.x
        self.moveByX(distance)
    }
    
    public func moveByX(x:CGFloat){
        var transform = self.transform
        transform = CGAffineTransformTranslate(transform, x, 0)
        self.transform = transform
    }
    
    public func moveToY(y:CGFloat){
        let distance = self.frame.origin.y - y
        self.moveByY(distance)
    }
    
    public func moveByY(y:CGFloat){
        var transform = self.transform
        transform = CGAffineTransformTranslate(transform, 0, y)
        self.transform = transform
    }
    
    public func scaleToX(x:CGFloat){
        let oldScaleX = self.transform.a
        let newScaleX = x / oldScaleX
        self.scaleByX(newScaleX)
    }
    
    public func scaleByX(x:CGFloat){
        var transform = self.transform
        transform = CGAffineTransformScale(transform, x, 1)
        self.transform = transform
    }
    
    public func scaleToY(y:CGFloat){
        let oldScaleY = self.transform.d
        let newScaleY = y / oldScaleY
        self.scaleByY(newScaleY)
    }
    
    public func scaleByY(y:CGFloat){
        var transform = self.transform
        transform = CGAffineTransformScale(transform, 1, y)
        self.transform = transform
    }
    
    public func rotateTo(angle:CGFloat){
        let transform = CGAffineTransformMakeRotation(degreesToRadians(angle))
        self.transform = transform
    }
    
    public func rotateBy(angle:CGFloat){
        var transform = self.transform
        transform = CGAffineTransformRotate(transform, degreesToRadians(angle) )
        self.transform = transform
    }
    
    
    // layoutConstraint
    
    private func layoutConstraintForAtt(att:NSLayoutAttribute)->NSLayoutConstraint?{
        
        let selfAllLayoutConstraint = self.constraints
        let superViewAllLayoutConstraint = self.superview?.constraints ?? []
        
        let allLayoutConstraint = selfAllLayoutConstraint + superViewAllLayoutConstraint
        
        for layoutConstraint in allLayoutConstraint{
            if let item = layoutConstraint.firstItem as? UIView where item == self && layoutConstraint.firstAttribute == att {
                return layoutConstraint
            }
        }
        
        return nil
    }
    
    public var leftConstant:Double{
        get{
            let layoutConstraint = self.layoutConstraintForAtt(.Left) ?? self.layoutConstraintForAtt(.Leading)
            return Double(layoutConstraint?.constant ?? 0)
        }
        set{
            let layoutConstraint = self.layoutConstraintForAtt(.Left) ?? self.layoutConstraintForAtt(.Leading)
            layoutConstraint?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var topConstant:Double{
        get{
            return Double(self.layoutConstraintForAtt(.Top)?.constant ?? 0)
        }
        set{
            self.layoutConstraintForAtt(.Top)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var rightConstant:Double{
        get{
            let layoutConstraint = self.layoutConstraintForAtt(.Right) ?? self.layoutConstraintForAtt(.Trailing)
            return Double(layoutConstraint?.constant ?? 0)
        }
        set{
            let layoutConstraint = self.layoutConstraintForAtt(.Right) ?? self.layoutConstraintForAtt(.Trailing)
            layoutConstraint?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var bottomConstant:Double{
        get{
            return Double(self.layoutConstraintForAtt(.Bottom)?.constant ?? 0 )
        }
        set{
            self.layoutConstraintForAtt(.Bottom)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var centerXConstant:Double{
        get{
            return Double(self.layoutConstraintForAtt(.CenterX)?.constant ?? 0)
        }
        set{
            self.layoutConstraintForAtt(.CenterX)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var centerYConstant:Double{
        get{
            return Double(self.layoutConstraintForAtt(.CenterY)?.constant ?? 0)
        }
        set{
            self.layoutConstraintForAtt(.CenterY)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var widthConstant:Double{
        get{
            return Double(self.layoutConstraintForAtt(.Width)?.constant ?? 0)
        }
        set{
            self.layoutConstraintForAtt(.Width)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var heightConstant:Double{
        get{
            return Double(self.layoutConstraintForAtt(.Height)?.constant ?? 0)
        }
        set{
            self.layoutConstraintForAtt(.Height)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
}