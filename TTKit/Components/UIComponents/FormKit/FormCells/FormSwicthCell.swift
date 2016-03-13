//
//  FormCellSwicth.swift
//  testTableView
//
//  Created by tanson on 15/12/30.
//  Copyright © 2015年 tanson. All rights reserved.
//

import UIKit

class FormSwicthCell: FormBaseCell {

    var action:(Bool->Void)?
    
    lazy var rightView:UISwitch = {
        let view = UISwitch()
        view.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
        return view
    }()
    
    init(title:String,detailText:String) {
        super.init(style: .Subtitle, reuseIdentifier: nil)
        textLabel?.text = title
        self.detailTextLabel?.text = detailText
        self.accessoryView = rightView
    }
    
    init(title:String){
        super.init(style: .Default, reuseIdentifier: nil)
        textLabel?.text = title
        self.accessoryView = rightView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getValue() -> Bool {
        return rightView.on
    }

    //
    @objc private func switchValueChanged(){
        if let block = self.action{
            block(self.rightView.on)
        }
    }
}
