//
//  FormSegmentedCell.swift
//  testTableView
//
//  Created by tanson on 16/1/2.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class FormSegmentedCell: FormBaseCell {

    var items:[String]
    
    var action:(Int->Void)?
    
    lazy var rightView:UISegmentedControl={
        var view = UISegmentedControl(items: self.items)
        view.addTarget(self, action: "valueChanged", forControlEvents: UIControlEvents.ValueChanged)
        return view
    }()
    
    init(title:String,detailText:String,items:[String]) {
        self.items = items
        super.init(style: .Default, reuseIdentifier: nil)
        accessoryType   = .None
        selectionStyle  = .None
        self.textLabel?.text = title
        self.detailTextLabel?.text = detailText
        self.accessoryView = rightView
    }

    init(title:String,items:[String]){
        self.items = items

        super.init(style: .Default, reuseIdentifier: nil)
        accessoryType   = .None
        selectionStyle  = .None
        textLabel?.text = title
        self.accessoryView = rightView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedIndex(index:Int){
        self.rightView.selectedSegmentIndex = index
    }

    @objc private func valueChanged(){
        if let block = self.action{
            block(self.rightView.selectedSegmentIndex)
        }
    }
}
