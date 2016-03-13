//
//  FormTextInputCell.swift
//  testTableView
//
//  Created by tanson on 16/2/21.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class FormTextInputCell: FormButtonCell {

    init(title: String) {
        super.init(title: title, style: FormButtonCellStyle.TitleLeft)
        self.accessoryType = .DisclosureIndicator
        self.action = { [weak self] btn in
            let controller = FormTextInputController()
            controller.value = self?.rightText
            controller.valueChangeBlock = { value in
                if let value = value {
                   self?.rightText = value 
                }
            }
            
            self?.builder?.controller?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
