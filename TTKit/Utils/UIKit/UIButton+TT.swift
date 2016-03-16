//
//  UIButton+TT.swift
//  TTKit
//
//  Created by tanson on 16/3/16.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    /**
     *  倒计时按钮
     *
     *  @param timeLine 倒计时总时间
     *  @param title    还没倒计时的title
     *  @param subTitle 倒计时中的子名字，如时、分
     *  @param mColor   还没倒计时的颜色
     *  @param color    倒计时中的颜色
     */
    func startWithTime(timeLine:Int,timerTitle:String ){
        
        
        //倒计时时间
        var timeOut = timeLine
        let title = self.titleLabel?.text ?? self.currentTitle ?? ""
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        
        //每秒执行一次
        dispatch_source_set_timer(timer, dispatch_walltime(nil, 0), 1 * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(timer) { [weak self] in
            
            //倒计时结束，关闭
            if timeOut <= 0 {
                dispatch_source_cancel(timer)
                dispatch_async(dispatch_get_main_queue()){ [weak self] in
                    self?.setTitle(title, forState: .Normal)
                    self?.enabled = true
                }
            } else {
                let allTime = timeLine + 1
                let seconds = timeOut % allTime
                let timeStr = String(format: "%0.2d", seconds)
                
                dispatch_async(dispatch_get_main_queue()){
                    self?.setTitle("\(timeStr)\(timerTitle)", forState: .Normal)
                    self?.enabled = false
                }
                timeOut--
            }
        }
        dispatch_resume(timer)
    }
}