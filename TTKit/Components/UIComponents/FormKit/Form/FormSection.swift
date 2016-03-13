//
//  FormSection.swift
//  testTableView
//
//  Created by tanson on 15/12/29.
//  Copyright © 2015年 tanson. All rights reserved.
//

import UIKit

class FormSection: NSObject {

    var cells = [FormBaseCell]()
    
    var headTitle:String?
    var footTitle:String?
    
    func headTitle(title:String)-> Self{
        self.headTitle = title
        return self
    }
    func footTitle(title:String)-> Self{
        self.footTitle = title
        return self
    }
    
    
    var cellsCount:Int{
        return self.cells.count
    }
    
    override init() {
        super.init()
    }
    
    
    func addNewCell(cell:FormBaseCell){
        
        if self.cells.count > 0 {
            self.cells[self.cells.count-1].isLastCell = false
        }
        cell.isLastCell = true
        self.cells.append(cell)
    }
    
    func cellForRow(row:Int)->FormBaseCell{
        return self.cells[row]
    }

}
