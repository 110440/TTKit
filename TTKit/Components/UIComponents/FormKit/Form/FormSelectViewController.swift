//
//  FormSelectViewController.swift
//  testTableView
//
//  Created by tanson on 16/1/1.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class FormSelectViewController: FormViewController {
    
    var isMultiSelect = false
    var optionItems = [String]()
    var curSelectedIndexs = [Int]()
    
    var didSelectBlock:((index:Int,title:String)->Void)?
    var didSelectMultiBlock:((index:[Int],title:[String])->Void)?
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addOptionItem(item:String){
        self.optionItems.append(item)
    }
    
    private func onSelectCell(index:Int){
        
        // 单选
        if !isMultiSelect {
            if let block = self.didSelectBlock{
                block(index: index, title: optionItems[index] )
                self.navigationController?.popViewControllerAnimated(true)
            }
        }else{
        // 多选
            self.curSelectedIndexs.append(index)
        }
    }
    
    private func onDeselectCell(index:Int){
        
        // 单选
        if !isMultiSelect {
            if let block = self.didSelectBlock{
                block(index: index, title: optionItems[index] )
                self.navigationController?.popViewControllerAnimated(true)
            }
        }else{
            // 多选
            self.curSelectedIndexs.removeAtIndex(self.curSelectedIndexs.indexOf(index)!)
        }
    }
    
    
    override func buildCells(builder: FormBuilder) {
        
        builder += FormSection()
        
        for i in 0 ..< self.optionItems.count {
            let item = self.optionItems[i]
            let cell = FormCheckCell(title: item)
            
            cell.action = {[weak self] cell in
                
                let cell = cell as! FormCheckCell
                if cell.getValue()  {
                    self?.onSelectCell(i)
                }else{
                    self?.onDeselectCell(i)
                }
            }
            
            // 标记当前选中项，可多选
            if let _ = self.curSelectedIndexs.indexOf(i){
                cell.setMarkOn()
            }
            
            builder += cell
        }
    }
    
    // 增加当前选中项
    func addSelectedIndex(idx:Int){
        self.curSelectedIndexs.append(idx)
    }

}
