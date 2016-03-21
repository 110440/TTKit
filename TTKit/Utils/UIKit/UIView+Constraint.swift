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
    
    private func layoutConstraintForFirstItemByAtt(att:NSLayoutAttribute)->NSLayoutConstraint?{
        
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
    
    private func layoutConstraintForSecondItemByAtt(att:NSLayoutAttribute)->NSLayoutConstraint?{
        
        let selfAllLayoutConstraint = self.constraints
        let superViewAllLayoutConstraint = self.superview?.constraints ?? []
        
        let allLayoutConstraint = selfAllLayoutConstraint + superViewAllLayoutConstraint
        
        for layoutConstraint in allLayoutConstraint{
            
            if let item = layoutConstraint.secondItem as? UIView where item == self && layoutConstraint.secondAttribute == att {
                return layoutConstraint
            }
        }
        
        return nil
    }
    
    public var leftConstant:Double{
        get{
            let layoutConstraint = self.layoutConstraintForFirstItemByAtt(.Left) ?? self.layoutConstraintForFirstItemByAtt(.Leading)
            return Double(layoutConstraint?.constant ?? 0)
        }
        set{
            let layoutConstraint = self.layoutConstraintForFirstItemByAtt(.Left) ?? self.layoutConstraintForFirstItemByAtt(.Leading)
            layoutConstraint?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var topConstant:Double{
        get{
            return Double(self.layoutConstraintForFirstItemByAtt(.Top)?.constant ?? 0)
        }
        set{
            self.layoutConstraintForFirstItemByAtt(.Top)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var rightConstant:Double{
        get{
            let layoutConstraint = self.layoutConstraintForSecondItemByAtt(.Right) ?? self.layoutConstraintForSecondItemByAtt(.Trailing)
            return Double(layoutConstraint?.constant ?? 0)
        }
        set{
            let layoutConstraint = self.layoutConstraintForSecondItemByAtt(.Right) ?? self.layoutConstraintForSecondItemByAtt(.Trailing)
            layoutConstraint?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var bottomConstant:Double{
        get{
            return Double(self.layoutConstraintForSecondItemByAtt(.Bottom)?.constant ?? 0 )
        }
        set{
            self.layoutConstraintForSecondItemByAtt(.Bottom)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var centerXConstant:Double{
        get{
            return Double(self.layoutConstraintForFirstItemByAtt(.CenterX)?.constant ?? 0)
        }
        set{
            self.layoutConstraintForFirstItemByAtt(.CenterX)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var centerYConstant:Double{
        get{
            return Double(self.layoutConstraintForFirstItemByAtt(.CenterY)?.constant ?? 0)
        }
        set{
            self.layoutConstraintForFirstItemByAtt(.CenterY)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var widthConstant:Double{
        get{
            return Double(self.layoutConstraintForFirstItemByAtt(.Width)?.constant ?? 0)
        }
        set{
            self.layoutConstraintForFirstItemByAtt(.Width)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var heightConstant:Double{
        get{
            return Double(self.layoutConstraintForFirstItemByAtt(.Height)?.constant ?? 0)
        }
        set{
            self.layoutConstraintForFirstItemByAtt(.Height)?.constant = CGFloat(newValue)
            self.superview?.layoutIfNeeded()
        }
        
    }
    
}