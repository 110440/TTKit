//
//  ViewController.swift
//  TTKit
//
//  Created by tanson on 16/2/24.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kit Demo"
        // Do any additional setup after loading the view, typically from a nib.
        
        // CLosureKit Test
        let barItem = UIBarButtonItem(title: "ClosureKit", style: .Plain) { (sender) -> Void in
            print("ClosureKit test")
        }
        self.navigationItem.rightBarButtonItem = barItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func buildCells(builder: FormBuilder) {
        builder += FormSection().headTitle("FormKit")
        builder += formTest
        
        builder += FormSection().headTitle("NetKit")
        builder += netKit
    }
    
    lazy var formTest:FormButtonCell = {
        let btn = FormButtonCell(title: "FormTest", rightText: "")
        btn.accessoryType = .DisclosureIndicator
        btn.action = { [weak self] btn in
            let weChatController = WeChatViewController()
            self?.navigationController?.pushViewController(weChatController, animated: true)
        }
        return btn
    }()

    lazy var netKit:FormButtonCell = {
        let btn = FormButtonCell(title: "NetKit", rightText: "")
        btn.accessoryType = .DisclosureIndicator
        return btn
    }()
}

