//
//  FormLabelCell.swift
//  testTableView
//
//  Created by tanson on 16/2/13.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

class FormLabelCell: FormBaseCell {
    
    var rightViewTrailingConstraint:NSLayoutConstraint?
    
    lazy var rightView:UILabel = {
        
        var lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textColor = UIColor.lightGrayColor()
        lab.textAlignment = .Right
        self.contentView.addSubview(lab)
        
        
        var rightPadding:CGFloat = 0
        if self.accessoryType == .None {
            rightPadding = -16
        }
        
        self.contentView.addConstraint(NSLayoutConstraint(item:lab, attribute: .Height, relatedBy: .Equal, toItem: self.contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item:lab, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        self.rightViewTrailingConstraint = NSLayoutConstraint(item:lab, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1.0, constant: rightPadding)
        self.contentView.addConstraint(self.rightViewTrailingConstraint!)
        
        return lab
        
    }()
    
    override var accessoryType:UITableViewCellAccessoryType{
        willSet{
            if newValue == .None {
                self.rightViewTrailingConstraint?.constant = -16
            }else{
                self.rightViewTrailingConstraint?.constant = 0
            }
        }
    }
    
    var rightText:String{
        get{
            return self.rightView.text ?? ""
        }
        set{
            self.rightView.text = newValue
        }
    }
    
    func rightText(text:String)->Self{
        self.rightText = text
        return self
    }
    
    func detailText(text:String)->Self{
        self.detailTextLabel?.text = text
        return self
    }
    
    
    init(title: String , rightText:String) {
        super.init(style: .Default, reuseIdentifier: nil)
        textLabel?.text = title
        accessoryType   = .None
        selectionStyle  = .None
        self.rightView.text = rightText
    }

    init(title: String , rightText:String , detailText:String ) {
        super.init(style: .Subtitle , reuseIdentifier: nil)
        textLabel?.text = title
        accessoryType   = .None
        selectionStyle  = .None
        self.detailTextLabel?.text = detailText
        self.rightView.text = rightText
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}