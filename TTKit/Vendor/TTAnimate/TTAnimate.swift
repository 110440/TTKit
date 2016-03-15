//
//  TTAnimate.swift
//  Demo
//
//  Created by tanson on 16/3/15.
//  Copyright © 2016年 miqu. All rights reserved.
//

import Foundation
import UIKit

class TTAnimate {
    
    // 当所有的动画都完成时被调用
    var completion:(()->Void)?
    func completion(c:()->Void){
        self.completion = c
    }
    
    //累计所有动画的 delay
    var delay:NSTimeInterval = 0
    //总共有多少个动画
    var count:Int = 0
    
    class func startAnimation(duration:NSTimeInterval,options:UIViewAnimationOptions = [] , action:()->Void ) ->TTAnimate {
        let animate = TTAnimate()
        return animate.thenAnimate(duration,options:options, action: action)
    }
    
    func thenAnimate(duration:NSTimeInterval , options:UIViewAnimationOptions = [] , action:()->Void ) ->Self {
        
        self.count++
        UIView.animateWithDuration(duration , delay:self.delay, options:options, animations: {
            action()
        }) { complate in
            self.count--
            if self.count <= 0{
                self.count = 0
                dispatch_async(dispatch_get_main_queue(), {
                    self.completion?()
                })
            }
        }
        self.delay += duration
        return self
    }
    
    func thenSpringAnimate(duration:NSTimeInterval , options:UIViewAnimationOptions = [] , damping:CGFloat = 0.4 ,velocity:CGFloat = 0.2, action:()->Void )->Self {
        
        self.count++
        UIView.animateWithDuration(duration, delay: self.delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: {
            action()
            }) { complate in
                self.count--
                if self.count <= 0{
                    self.count = 0
                    dispatch_async(dispatch_get_main_queue(), {
                        self.completion?()
                    })
                }
        }
        self.delay += duration
        return self
    }
    
    func waitFor(duration:NSTimeInterval)->Self{
        self.delay += duration
        return self
    }
}

