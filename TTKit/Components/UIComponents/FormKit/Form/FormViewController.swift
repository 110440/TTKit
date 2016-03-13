//
//  FormViewController.swift
//  testTableView
//
//  Created by tanson on 15/12/29.
//  Copyright © 2015年 tanson. All rights reserved.
//

import UIKit

class FormViewController: UIViewController ,FormHeightForSectionProtocol{

    lazy var keyboardMan:KeyboardMan = {
        let keyboardMan = KeyboardMan()
        return keyboardMan
    }()
    
    let spaceBetweenCellAndKeyboard: CGFloat = 30
    var formDataDelegate:FormDataDelegate?
    
    lazy var formBuilder:FormBuilder = {
        return FormBuilder(controller: self)
    }()
    
    lazy var tableView: UITableView = {
        var view = UITableView(frame: CGRectZero, style: .Grouped)
        view.contentInset = UIEdgeInsetsZero
        view.scrollIndicatorInsets = UIEdgeInsetsZero
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildCells(formBuilder)
        
        self.formDataDelegate       = self.formBuilder.buildFormDataDelegate()
        self.formDataDelegate?.controller = self
        self.tableView.dataSource   = self.formDataDelegate
        self.tableView.delegate     = self.formDataDelegate
        
        self.keyboardHandle()
    }
    
    override func loadView() {
        self.view = self.tableView
    }
    
    
    func buildCells(builder: FormBuilder) {
        fatalError("====== FormViewController : subclass must override buildCells()======")
    }
    
    func heightForHeadSection(section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func heightForFootSection(section: Int) -> CGFloat {
        if let _ = self.formDataDelegate?.sections[section].headTitle {
            return UITableViewAutomaticDimension
        }
        return 4
    }
    
    //MARK:- 键盘通知
    private func keyboardHandle(){
        
        self.keyboardMan.animateWhenKeyboardAppear = { [weak self] appearPostIndex, keyboardHeight, keyboardHeightIncrement in
            
            //print(keyboardHeight)
            
            let screentHeight = UIScreen.mainScreen().bounds.size.height
            
            guard let strongSelf = self else{
                return
            }
            
            guard let focusOnCell = strongSelf.tableView.form_firstResponder()?.form_cell() else{
                return
            }
            guard let indexPath = strongSelf.tableView.indexPathForCell(focusOnCell) else{
                return
            }
            let rectForFocusCell = strongSelf.tableView.rectForRowAtIndexPath(indexPath)
            
            guard let window = strongSelf.tableView.window else{
                return
            }
            let rectForFocusCellInWindow = window.convertRect(rectForFocusCell, fromView: strongSelf.tableView)
            
            let maxY = CGRectGetMaxY(rectForFocusCellInWindow) + strongSelf.spaceBetweenCellAndKeyboard
            
            let dis = maxY - (screentHeight - keyboardHeight)
            
            if dis > 0 {
                
                strongSelf.tableView.contentOffset.y += dis
                strongSelf.tableView.contentInset.bottom = keyboardHeight + strongSelf.spaceBetweenCellAndKeyboard
                
            }

        }
        
        self.keyboardMan.animateWhenKeyboardDisappear = { [weak self] keyboardHeight in
            
            if let strongSelf = self {
                
                strongSelf.tableView.contentInset.bottom = 0
                
            }
        }

    }
    
    //MARK:- 输入有效验证
    func liveValidate()->String?{
        let sections = self.formDataDelegate?.sections
        for section in sections! {
            for cell in section.cells{
                if let cell = cell as? FormCellValidatorProtocol{
                    let msg = cell.checkValidator()
                    if let _ = msg{
                        return msg 
                    }
                }
            }
        }
        return nil
    }
}
