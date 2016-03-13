//
//  FormStatcTextCell.swift
//  testTableView
//
//  Created by tanson on 15/12/31.
//  Copyright © 2015年 tanson. All rights reserved.
//

import UIKit

class FormOptionTextCell: FormLabelCell , FormCellSelectProtocol{

    var optionItems = [String]()
    var curSelectItems  = [String]()
    var curSelectIndexs = [Int]()
    var isMultiSelect = false
    
    var didSelectBlock:((Int,String) ->Void)?
    
    override init(title: String, rightText: String) {
        super.init(title: title, rightText: rightText)
        self.accessoryType = .DisclosureIndicator
    }
    
    override init(title: String, rightText: String, detailText: String) {
        super.init(title: title, rightText: rightText, detailText: detailText)
        self.accessoryType = .DisclosureIndicator
    }
    
    convenience init(title: String) {
        self.init(title:title, rightText: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getValue() -> String? {
        let value = self.rightView.text
        return value
    }

    
    func addSelectItem(item:String){
        if !self.isMultiSelect {
            self.curSelectItems.removeAll()
        }
        self.curSelectItems.append(item)
    }
    
    func addSelectIdx(index:Int ){
        self.curSelectIndexs.append(index)
    }
    
    override var rightText:String{
        get{
            return super.rightText
        }
        set{
            super.rightText = newValue
            self.addSelectItem(newValue)
        }
    }
    
    // protocol
    func formDidSelectRow(indexPath: NSIndexPath, tableView: UITableView) {
        self.setSelected(false, animated: true)
        
        let optionVC = FormSelectViewController()
        optionVC.title = self.textLabel?.text
        optionVC.optionItems = self.optionItems
        
        
        // 用值指定选中项
        for selectItem in self.curSelectItems{
            if let index = self.optionItems.indexOf(selectItem) {
                optionVC.addSelectedIndex(index)
            }
        }
        
        // 用索引指定选中项
        for selectIdx in self.curSelectIndexs{
            optionVC.addSelectedIndex(selectIdx)
        }
        
        optionVC.didSelectBlock = { [weak self] index,title in
            self?.rightText = title
            if let block = self?.didSelectBlock{
                block(index,title)
            }
        }
        
        self.builder?.controller?.navigationController?.pushViewController(optionVC, animated: true)
    }
    
}
