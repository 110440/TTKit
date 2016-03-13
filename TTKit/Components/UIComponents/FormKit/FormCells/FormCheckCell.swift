//
//  FormCheckCell.swift
//  testTableView
//
//  Created by tanson on 15/12/29.
//  Copyright © 2015年 tanson. All rights reserved.
//

import UIKit

class FormCheckCell: FormBaseCell , FormCellSelectProtocol{

    var value:Bool = false
    var action:(FormBaseCell->Void)?
    
    init(title:String,detailText:String) {
        
        super.init(style: .Default, reuseIdentifier: nil)
        textLabel?.text = title
        accessoryType   = .None
        selectionStyle  = .Blue
        self.detailTextLabel?.text = detailText
    }
    
    init(title:String){
        
        super.init(style: .Default, reuseIdentifier: nil)
        textLabel?.text = title
        accessoryType   = .None
        selectionStyle  = .Blue
    }

    func setMarkOn(){
        value = true
        accessoryType = .Checkmark
    }
    func setMarkOff(){
        value = false
        accessoryType = .None
    }
    
    func formDidSelectRow(indexPath: NSIndexPath, tableView: UITableView) {
        self.setSelected(false, animated: true)
        
        if self.value {
            self.setMarkOff()
        }else{
            self.setMarkOn()
        }
        
        if let block = self.action{
            block(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getValue() -> Bool {
        return self.value
    }
}
