//
//  TTImageViewerCell2TableViewCell.swift
//  TestAnimations
//
//  Created by tanson on 16/3/19.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class TTImageViewerCell: UICollectionViewCell {

    var action:(()->Void)?
    
    lazy var scrollView:ZoomImageScrollView = {
        let view = ZoomImageScrollView(frame:CGRect(x:tt_pageSpace, y: 0, width: self.bounds.size.width-tt_pageSpace*2, height: self.bounds.size.height))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.scrollView)
        self.scrollView.clickAction = {
            self.action?()
        }
    }

    func setImageCellItem(item:TTImageViewerItem){
        
        self.scrollView.setImage(item.thumbImageView.image!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
