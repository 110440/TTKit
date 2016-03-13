//
//  TestNibCell.swift
//  testTableView
//
//  Created by tanson on 16/1/3.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class TestNibCell: FormBaseCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
