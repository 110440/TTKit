//
//  DesignableButton.swift
//  TestAnimations
//
//  Created by tanson on 16/3/14.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit


@IBDesignable public class DesignableButton: UIButton {
    
    @IBInspectable public var colorForDefault:UIColor = UIColor.clearColor() {
        didSet{
            let image = UIImage.imageWithColor(colorForDefault, size: CGSize(width: 1, height: 1))
            self.setBackgroundImage(image, forState: .Normal)
        }
    }
    
    @IBInspectable public var colorForSelected:UIColor = UIColor.clearColor() {
        didSet{
            let image = UIImage.imageWithColor(colorForSelected, size: CGSize(width: 1, height: 1))
            self.setBackgroundImage(image, forState: .Highlighted)
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.shadowColor = shadowColor.CGColor
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable public var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
    
}

