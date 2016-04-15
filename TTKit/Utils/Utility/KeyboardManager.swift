//
//  KeyboardMan.swift
//  Messages
//
//  Created by NIX on 15/7/25.
//  Copyright (c) 2015年 nixWork. All rights reserved.
//

import UIKit

public class KeyboardManager: NSObject {
    
    typealias keyboardEvenHandel = (keyboardHeight:CGFloat)->Void
    
    var animateWhenKeyboardAppear:keyboardEvenHandel?
    var animateWhenKeyboardDisappear:keyboardEvenHandel?
    
    var isKeyboradShowNow:Bool = false
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    override init() {
        super.init()
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector:#selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        
        guard UIApplication.sharedApplication().applicationState != .Background else {
            return
        }
        
        self.handleKeyboard(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        guard UIApplication.sharedApplication().applicationState != .Background else {
            return
        }
        self.handleKeyboard(notification)
    }

    private func handleKeyboard(notification: NSNotification) {

        if let userInfo = notification.userInfo {
            
            let screentSize = UIScreen.mainScreen().bounds.size
            let animationDuration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            let animationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedLongValue
            let frameBegin = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
            let frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            
            let options = UIViewAnimationOptions(rawValue: animationCurve << 16 | UIViewAnimationOptions.BeginFromCurrentState.rawValue)
            
            UIView.animateWithDuration(animationDuration, delay: 0, options: options, animations: {
                
                if frameBegin.minY >= screentSize.height {
                    //弹出
                    self.isKeyboradShowNow = true
                    self.animateWhenKeyboardAppear?(keyboardHeight:frameEnd.height)
                }else {
                    if frameEnd.minY >= screentSize.height{
                        //消失
                        self.isKeyboradShowNow = false
                        self.animateWhenKeyboardDisappear?(keyboardHeight:frameEnd.height)
                    }else{
                        //大小改变
                        self.animateWhenKeyboardAppear?(keyboardHeight:frameEnd.height)
                    }
                    
                }
            }, completion: nil)

        }
    }
}

