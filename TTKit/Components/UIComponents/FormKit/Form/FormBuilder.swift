//
//  FormBuilder.swift
//  testTableView
//
//  Created by tanson on 15/12/29.
//  Copyright © 2015 tanson. All rights reserved.
//

import UIKit

class FormBuilder: NSObject {

    var sections = [FormSection]()
    
    weak var controller:FormViewController?
    
    init(controller:FormViewController) {
        self.controller = controller
        super.init()
    }
    
    func buildFormDataDelegate()->FormDataDelegate {
        let delegate = FormDataDelegate(sections: self.sections)
        return delegate
    }
    
    //MARK:- private 
    
    private var currentSection:FormSection? {
        get {
            return self.sections.last
        }
    }
    
    private func addNewSection(s:FormSection){
        self.sections.append(s)
    }
    
}


//MARK:- 重载 +=

func += (left:FormBuilder , right:FormSection){
    left.addNewSection(right)
}

func += (left:FormBuilder , right:FormBaseCell){
    
    if let curSection = left.currentSection{
        curSection.addNewCell(right)
        right.builder = left
        right.controller = left.controller
    }else{
        print(" FormBuilder class +=() : ======== must add a section at first ========== ")
    }
}
