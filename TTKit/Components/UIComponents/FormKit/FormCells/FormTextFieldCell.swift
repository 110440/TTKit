//
//  FormTextFieldCell.swift
//  testTableView
//
//  Created by tanson on 15/12/31.
//  Copyright © 2015 tanson. All rights reserved.
//

import UIKit

class FormTextFieldCell: FormBaseCell,FormCellOnFoucsProtocol,UITextFieldDelegate,FormCellValidatorProtocol{

    // 格式验证
    var validators = [FormValidator]()
    
    // 下一个获取输入的Cell
    var nextInputView:FormTextFieldCell? {
        willSet{
            self.textField.returnKeyType = .Next
        }
    }
    
    //TODO
    func getValue()->String?{
        return self.textField.text
    }
    
    var inputTextOffset:Float? {
        get{
            return Float( self.textField.leftView?.frame.size.width ?? 0 )
        }
        set{
            let leftView = UIView(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(newValue!), height: CGFloat(10.0) ) )
            self.textField.textAlignment = .Left
            self.textField.leftView = leftView
            self.textField.leftViewMode = .Always
        }
    }
    
    lazy var textField:UITextField = {
        
        var field = UITextField(frame:CGRectZero )
        field.returnKeyType = .Done
        field.textAlignment = .Right
        field.autocapitalizationType = .None
        field.delegate = self
        field.addTarget(self , action: "editingOnBegin:", forControlEvents: [.EditingDidBegin])
        self.contentView.addSubview(field)
        
        field.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item:field, attribute: .Height, relatedBy: .Equal, toItem: self.contentView, attribute: .Height, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item:field, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item:field, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1.0, constant: -16))
        self.contentView.addConstraint(NSLayoutConstraint(item:field, attribute: .Width, relatedBy: .Equal, toItem: self.contentView, attribute: .Width, multiplier: 1.0, constant: 0))
        
        return field
    }()
   
    init(title:String,detailText:String) {
        
        super.init(style: .Subtitle , reuseIdentifier: nil)
        textLabel?.text = title
        accessoryType   = .None
        selectionStyle  = .None
        self.detailTextLabel?.text = detailText
    }
    
    init(title:String){
        
        super.init(style: .Default, reuseIdentifier: nil)
        textLabel?.text = title
        accessoryType   = .None
        selectionStyle  = .None
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetIsPassWord(value:Bool)->Self{
        self.textField.secureTextEntry = value
        return self
    }
    
    func placeholder(text:String)->Self{
        
        self.textField.placeholder = text
        self.textField.sizeToFit()
        return self
    }
    
    func showClearButtonWhileEditting()->Self{
        self.textField.clearButtonMode = .WhileEditing
        return self
    }
    
    
    func setKeyboardType(type:UIKeyboardType)->Self{
        self.textField.keyboardType = type
        return self
    }
    
    func goNextInputView(){
        
        if let next = self.nextInputView {
            next.textField.becomeFirstResponder()
        }
    }
    
    // event
    internal func editingOnBegin(sender: UITextField) {
        //从一个textField 转到另一个textField 再次触发键键弹出事件以滚动cell?
        //sender.becomeFirstResponder()
    }
    
    //MARK:- protocol
    func formCellOnFoucs(cell: UITableViewCell) {
        if cell != self{
            self.textField.resignFirstResponder()
        }
    }
    
    //MARK:- Validate
    func addValidator(validator:FormValidator){
        self.validators.append(validator)
    }
    
    func emailValidator(errorMsg:String = "无效邮箱地址")->FormValidator{
        
        func validator()->FormValidateResult{
            guard let str = self.textField.text else{
                return FormValidateResult.Error(errorMsg)
            }
            let pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            let ret =  str.form_matchesRegex(pattern)
            if ret {
                return FormValidateResult.OK
            }else{
                return FormValidateResult.Error(errorMsg)
            }
        }
        return validator
    }
    
    func siteValidator(errorMsg:String = "无效网址")->FormValidator{
        
        func validator()->FormValidateResult{
            guard let str = self.textField.text else{
                return FormValidateResult.Error(errorMsg)
            }
            let pattern = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
            let ret =  str.form_matchesRegex(pattern)
            if ret {
                return FormValidateResult.OK
            }else{
                return FormValidateResult.Error(errorMsg)
            }
        }
        return validator
    }
    
    func phoneNumberValidator(errorMsg:String = "无效电话号码")->FormValidator{
        
        func validator()->FormValidateResult{
            guard let str = self.textField.text else{
                return FormValidateResult.Error(errorMsg)
            }
            let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
            let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
            let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
            let CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
            let ret = str.form_matchesRegex(mobile) || str.form_matchesRegex(CM) || str.form_matchesRegex(CU) || str.form_matchesRegex(CT)
            if ret {
                return FormValidateResult.OK
            }else{
                return FormValidateResult.Error(errorMsg)
            }
        }
        return validator
    }
    
    func inputValidator(mix:Int, max:Int, errorMsg:String = "无效输入长度")->FormValidator{
        
        func validator()->FormValidateResult{
            guard let str = self.textField.text else{
                return FormValidateResult.Error(errorMsg)
            }
            
            let strLengt = str.characters.count
            if strLengt >= mix && strLengt <= max {
                return FormValidateResult.OK
            }else{
                return FormValidateResult.Error(errorMsg)
            }
        }
        return validator
    }
}
