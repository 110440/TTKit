//
//  UIView+KeyboardManager.swift
//  TTKit
//
//  Created by tanson on 16/3/20.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

private var associatedKeyboardManager: UInt8 = 0

extension UIView {
    
    private func keyboard_firstResponder() -> UIView? {
        if self.isFirstResponder() {
            return self
        }
        for subview in subviews {
            let responder = subview.keyboard_firstResponder()
            if responder != nil {
                return responder
            }
        }
        return nil
    }
    
    private var keyboarManager:KeyboardManager{
        get {
            var keyMgr = objc_getAssociatedObject(self, &associatedKeyboardManager) as? KeyboardManager
            if keyMgr == nil {
                keyMgr = KeyboardManager()
                objc_setAssociatedObject(self, &associatedKeyboardManager, keyMgr,
                    objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return keyMgr!
        }
    }
    
    func avoidKeyboardWithSpace(space:CGFloat){
        
        self.keyboarManager.animateWhenKeyboardAppear = { [weak self] keyboardHeight in
            guard let view  = self else{return}
            guard let window = view.window else {return}
            let screentHeight = window.bounds.height
            guard let responder = view.keyboard_firstResponder() else {return}
            
            let frameInWindow = window.convertRect(responder.frame, fromView: responder.superview)
            
            let maxY = CGRectGetMaxY(frameInWindow) + space
            
            let dis = maxY - (screentHeight - keyboardHeight)
            
            if dis > 0 {
                view.transform = CGAffineTransformMakeTranslation(0, -dis)
            }
        }
        
        self.keyboarManager.animateWhenKeyboardDisappear = { [weak self] keyboardHeight in
            self?.transform = CGAffineTransformIdentity
        }
    }
}
