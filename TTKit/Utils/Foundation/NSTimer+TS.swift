//
//  NSTimer+TS.swift
//  TSKit
//
//  Created by tanson on 16/1/22.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation

typealias TSTimeBlock = (timer:NSTimer)->()

extension NSTimer{
    
    class func scheduledTimerWithTimeInterval(seconds:NSTimeInterval,repeats:Bool,block:TSTimeBlock)->NSTimer{
        let timerWrapper = TimerClosureWrapper(handler: block, repeats: repeats)
        return NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "_TS_ExecBlock:",userInfo: timerWrapper, repeats: repeats)
    }
    
    class func timerWithTimeInterval(seconds:NSTimeInterval,repeats:Bool,block:TSTimeBlock)->NSTimer{
        let timerWrapper = TimerClosureWrapper(handler: block, repeats: repeats)
        return NSTimer(timeInterval: seconds, target: self, selector: "_TS_ExecBlock:", userInfo: timerWrapper, repeats: repeats)
    }
    
    @objc
    class private func _TS_ExecBlock(timer:NSTimer){
        if let timerWrapper = timer.userInfo as? TimerClosureWrapper{
            timerWrapper.handler(timer: timer)
        }
    }
    
}

private final class TimerClosureWrapper{
    
    var handler:TSTimeBlock
    var repeats:Bool
    
    init(handler:TSTimeBlock,repeats:Bool){
        self.handler = handler
        self.repeats = repeats
    }
}