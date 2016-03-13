//
//  FormButtonCell.swift
//  testTableView
//
//  Created by tanson on 15/12/29.
//  Copyright © 2015年 tanson. All rights reserved.
//

import UIKit

enum FormButtonCellStyle{
    case TitleCenter
    case TitleLeft
    case TitleLeftAndDetail
}

class FormButtonCell: FormLabelCell ,FormCellSelectProtocol{
    
    var action:(FormBaseCell->Void)?
    
    var enabled = true {
        didSet  {
            if enabled {
                self.selectionStyle = .Blue
                self.textLabel?.textColor = UIColor.blackColor()
            }else{
                self.selectionStyle = .None
                self.textLabel?.textColor = UIColor.grayColor()
            }
        }
    }
    
    init(title:String,style:FormButtonCellStyle){
        
        switch style{
        case .TitleCenter:
            super.init(title: title, rightText: "")
            textLabel?.textAlignment = NSTextAlignment.Center
        case .TitleLeft:
            super.init(title: title, rightText: "")
            textLabel?.textAlignment = NSTextAlignment.Left
        case .TitleLeftAndDetail:
            super.init(title: title, rightText: "", detailText: "")
            textLabel?.textAlignment = NSTextAlignment.Left
        }
        
        selectionStyle  = .Blue
    }
    
    // 标题居中
    convenience init(title:String){
        self.init(title:title,style:.TitleCenter)
    }

    // 标题居左 ，右边也有文字
    convenience  override init(title: String, rightText: String) {
        self.init(title:title,style:.TitleLeft)
        self.rightText(rightText)
    }
    
    // 标题居左 ，下面还有描述
    convenience init(title: String, detailText: String) {
        self.init(title:title,style:.TitleLeftAndDetail)
        self.detailText(detailText)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setButtonCornerRadius(r:CGFloat){
        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.redColor()
        self.contentView.layer.cornerRadius = r
    }
    
    func setButtonTitleColor(color:UIColor){
        self.textLabel?.tintColor = color
    }
    
    // Protocol
    
    func formDidSelectRow(indexPath: NSIndexPath, tableView: UITableView) {
        self.setSelected(false, animated: true)
        if let block = self.action{
            if self.enabled {
                block(self)
            }
        }
    }

}
