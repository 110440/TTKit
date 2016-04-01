
//
//  String+tt.swift
//  TTKit
//
//  Created by tanson on 16/4/1.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation

extension String{
    
    // bytes , KB , MB , GB , T
    func stringFromByteCount(byteCount:Int64)->String{
        return NSByteCountFormatter.stringFromByteCount(byteCount, countStyle: NSByteCountFormatterCountStyle.Binary)
    }
}