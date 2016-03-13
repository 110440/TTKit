//
//  WeChatViewController.swift
//  testTableView
//
//  Created by tanson on 16/2/19.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class WeChatViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "WeChat"
    }
    
    override func buildCells(builder: FormBuilder) {
        
        builder += FormSection()
        builder += photo
        builder += favors
        builder += money
        
        builder += FormSection()
        builder += face
        
        builder += FormSection()
        builder += setting
    }
    
    lazy var photo:FormButtonCell = {
        var btn = FormButtonCell(title: "相册", rightText: "")
        btn.setLeftImage(UIImage(named: "me_photo")!)
        btn.setSeparatorInsetZero()
        btn.accessoryType = .DisclosureIndicator
        
        btn.action = { [weak self] btn in
            print("相册")
        }
        return btn
    }()
    
    lazy var favors:FormButtonCell = {
       var btn = FormButtonCell(title: "收藏", rightText: "")
        btn.setLeftImage(UIImage(named: "me_collect")!)
        btn.setSeparatorInsetZero()
        btn.accessoryType = .DisclosureIndicator
        btn.action = { [weak self] btn in
            print("收藏")
        }
        return btn
        
    }()
    
    lazy var money:FormButtonCell = {
       var btn = FormButtonCell(title: "钱包", rightText: "")
        btn.setLeftImage(UIImage(named: "me_money")!)
        btn.setSeparatorInsetZero()
        btn.accessoryType = .DisclosureIndicator
        btn.action = { [weak self] btn in
            print("钱包")
        }
        return btn
    }()
    
    lazy var face:FormButtonCell = {
       var btn = FormButtonCell(title: "表情", rightText: "")
        btn.setLeftImage(UIImage(named: "me_smail")!)
        btn.accessoryType = .DisclosureIndicator
        btn.action = { [weak self] btn in
            print("表情")
        }
        return btn
    }()
    
    lazy var setting:FormButtonCell = {
       var btn = FormButtonCell(title: "设置", rightText: "")
        btn.setLeftImage(UIImage(named: "me_setting")!)
        btn.accessoryType = .DisclosureIndicator
        btn.action = { [weak self] btn in
            let vc = WeChatSettingController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return btn
    }()
}
