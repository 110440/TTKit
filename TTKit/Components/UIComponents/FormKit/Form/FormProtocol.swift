//
//  FormProtocol.swift
//  testTableView
//
//  Created by tanson on 15/12/29.
//  Copyright © 2015年 tanson. All rights reserved.
//

import UIKit

// 选中cell
protocol FormCellSelectProtocol {
    func formDidSelectRow(indexPath: NSIndexPath, tableView: UITableView)
}

// cell 失去选择
protocol FormCellDeselectProtocol{
    func formDidDeselectRow(indexPath: NSIndexPath, tableView: UITableView)
}

// 自定义高度cell
protocol FormCellCustomHeightProtocol{
    func formCellHeight()->CGFloat
}

//
protocol FormHeightForSectionProtocol{
    func heightForHeadSection(section:Int)->CGFloat
    func heightForFootSection(section:Int)->CGFloat
}

//
protocol FormCellOnFoucsProtocol{
    func formCellOnFoucs(cell:UITableViewCell)
}

// 格式验证
protocol FormCellValidatorProtocol{
    var validators:[FormValidator]{set get}
    func addValidator(validator:FormValidator)
    func checkValidator()->String?
}
extension FormCellValidatorProtocol{
    
    func checkValidator()->String?{
        var retMsg:String?
        for validator in self.validators {
            let result = validator()
            switch result{
            case .OK:
                break
            case .Error(let msg):
                retMsg = msg
            }
            if retMsg != nil {
                break
            }
        }
        return retMsg
    }
}