//
//  UIView+Constraint.swift
//  TTKit
//
//  Created by tanson on 16/3/20.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

// layoutConstraint
extension UIView{
    
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