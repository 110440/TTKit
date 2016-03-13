//
//  WeChatSettingController.swift
//  TTKit
//
//  Created by tanson on 16/2/24.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class WeChatSettingController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
    }
    
    override func buildCells(builder: FormBuilder) {
        
        builder += FormSection()
        builder += name
        builder += sex
        builder += city
        builder += status
        
        builder += FormSection()
        builder += out
        
    }
    
    lazy var name:FormTextInputCell = {
       let cell = FormTextInputCell(title: "名字:")
        return cell
    }()
    
    lazy var sex:FormOptionTextCell = {
       let cell = FormOptionTextCell(title: "性别:")
        cell.optionItems = ["男","女"]
        return cell
    }()
    
    lazy var city:FormCitySelectCell = {
       let cell = FormCitySelectCell(title: "城市:")
        return cell
    }()
    
    lazy var status:FormSwicthCell = {
       let cell = FormSwicthCell(title: "在线:",detailText: "是否让你的好友看见你")
        cell.detailTextColor = UIColor.lightGrayColor()
        return cell
    }()
    
    lazy var out:FormButtonCell = {
       let btn = FormButtonCell(title: "退出账号")
        return btn
    }()
    
    
}
