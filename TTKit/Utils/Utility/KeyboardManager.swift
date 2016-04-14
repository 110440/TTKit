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
 
    enum EvenType{
        case Show
        case Hide
    }
    
    override init() {
        super.init()
        //notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
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
        
        if isKeyboradShowNow == false{
            isKeyboradShowNow = true
            self.handleKeyboard(notification, even: .Show)
        }else{
            isKeyboradShowNow = false
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        guard UIApplication.sharedApplication().applicationState != .Background else {
            return
        }
        isKeyboradShowNow = false
        self.handleKeyboard(notification, even: .Hide)
    }

    private func handleKeyboard(notification: NSNotification,even:EvenType) {

        if let userInfo = notification.userInfo {

            let animationDuration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            let animationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedLongValue
            //let frameBegin = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
            let frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            
            let options = UIViewAnimationOptions(rawValue: animationCurve << 16 | UIViewAnimationOptions.BeginFromCurrentState.rawValue)
            
            UIView.animateWithDuration(animationDuration, delay: 0, options: options, animations: {
                
                switch even{
                case .Show:
                    self.animateWhenKeyboardAppear?(keyboardHeight:frameEnd.height)
                case .Hide:
                    self.animateWhenKeyboardDisappear?(keyboardHeight:frameEnd.height)
                }
                
            }, completion: nil)

        }
    }
}

