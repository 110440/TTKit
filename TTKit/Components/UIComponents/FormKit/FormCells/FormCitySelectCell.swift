//
//  FormCitySelectCell.swift
//  testTableView
//
//  Created by tanson on 16/1/4.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class FormCitySelectCell: FormOptionTextCell {

    var cityDidSelect:((String,String,String?)->Void)?
    
    override init(title: String, rightText: String) {
        super.init(title: title, rightText: rightText)
    }
    
    convenience init(title: String) {
        self.init(title: title, rightText: "")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // protocol
    override func formDidSelectRow(indexPath: NSIndexPath, tableView: UITableView) {
        self.setSelected(false, animated: true)
        
        let cityVC = FormCitySelectViewController()
        cityVC.title = "城市选择"
        cityVC.parentController = self.builder?.controller
        
        cityVC.cityDidSelect = { [weak self] province,city,area in
            let showStr = " \(province) \(city) \(area ?? "")"
            self!.rightText = showStr
            
            if let block = self!.cityDidSelect{
                block(province,city,area)
            }
        }
        
        self.builder?.controller?.navigationController?.pushViewController(cityVC, animated: true)
    }
    
    
}
