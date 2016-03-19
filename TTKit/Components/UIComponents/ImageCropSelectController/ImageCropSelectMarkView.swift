//
//  ImageCropSelectMarkView.swift
//  TestAnimations
//
//  Created by tanson on 16/3/18.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

enum MarkStyle{
    case Rectangle
    case Circle
}

class ImageCropSelectMarkView:UIView {
    
    var markStyle:MarkStyle
    var cropRect:CGRect
    
    init(style:MarkStyle,rect:CGRect){
        
        self.markStyle = style
        self.cropRect = rect
        super.init(frame:CGRectZero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        let contextRef = UIGraphicsGetCurrentContext()
        CGContextSaveGState(contextRef)
        CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.35)
        CGContextSetLineWidth(contextRef, 2)
        
        let pickingFieldPath = self.markPathForMarkSyle()
        let bezierPathRect = UIBezierPath(rect: self.cropRect)
        bezierPathRect.appendPath(pickingFieldPath)
        bezierPathRect.usesEvenOddFillRule = true
        bezierPathRect.fill()
        
        CGContextSetLineWidth(contextRef, 2)
        CGContextSetRGBStrokeColor(contextRef, 255, 255, 255, 1)

        let dash:[CGFloat] = [4,4]
        pickingFieldPath.setLineDash(dash, count: 2, phase: 0)
        pickingFieldPath.stroke()
        
        CGContextRestoreGState(contextRef)
        self.layer.contentsGravity = kCAGravityCenter
        
//        if ([self.delegate respondsToSelector:@selector(pickingFieldRectChangedTo:)]) {
//            [self.delegate pickingFieldRectChangedTo:self.pickingFieldRect];
//        }
        
    }
    
    //MARK:- private
    func markPathForMarkSyle()->UIBezierPath{
        switch self.markStyle{
        case .Rectangle:
            return UIBezierPath(rect: self.cropRect)
        case .Circle:
            return UIBezierPath(ovalInRect: self.cropRect)
        }
    }
}