//
//  FormTextInputController.swift
//  testTableView
//
//  Created by tanson on 16/2/21.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class FormTextInputController: UIViewController , UITextFieldDelegate {

    typealias valueBlock = (value:String?)->Void
    
    var valueChangeBlock:valueBlock?
    
    var value:String? {
        set{
            self.inputTextField.text = newValue
        }
        get{
            return self.inputTextField.text
        }
    }
    
    lazy var inputTextField:UITextField = {
        let view = UITextField()
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        view.leftView = paddingView
        view.leftViewMode = .Always
        view.backgroundColor = UIColor.whiteColor()
        view.placeholder = "输入..."
        view.delegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        
        // barButton
        let rightBarItem = UIBarButtonItem(title: "确定", style: .Plain, target: self, action: "submit")
        rightBarItem.enabled = false
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc private func submit(){
        
        if let block = self.valueChangeBlock{
            block(value:self.inputTextField.text)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    private func initView(){
        
        self.view.backgroundColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 244/255.0, alpha: 1)
        self.view.addSubview(self.inputTextField)
        self.inputTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(NSLayoutConstraint(item:self.inputTextField, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Baseline, multiplier: 1.0, constant: 20.0))
        self.view.addConstraint(NSLayoutConstraint(item:self.inputTextField, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item:self.inputTextField, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0.0))
        
        self.inputTextField.addConstraint(NSLayoutConstraint(item:self.inputTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 44))
    }
    
    //MARK:- life
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.inputTextField.becomeFirstResponder()
    }
    
    //MARK:- textfield delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.navigationItem.rightBarButtonItem?.enabled = true
        return true
    }
}
