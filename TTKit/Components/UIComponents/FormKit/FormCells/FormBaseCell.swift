//
//  FormBaseCell.swift
//  testTableView
//
//  Created by tanson on 15/12/29.
//  Copyright © 2015年 tanson. All rights reserved.
//

import UIKit

class FormBaseCell: UITableViewCell {

    weak var builder:FormBuilder?
    weak var controller:FormViewController?
    var isLastCell:Bool = false

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType   = .None
        selectionStyle  = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setLeftImage(img:UIImage){
        self.imageView?.image = img
    }
    
    func setLeftImageWith(img:UIImage,size:CGSize = CGSize(width: 32, height: 32) ){
        
        let desSize = size
        UIGraphicsBeginImageContextWithOptions(desSize, false, 0.0)
        img.drawInRect(CGRect(x: 0, y: 0, width: desSize.width, height: desSize.height))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.imageView?.image = newImg
    }
    
    var detailTextColor:UIColor? {
        get{
            return self.detailTextLabel?.textColor
        }
        set{
            self.detailTextLabel?.textColor = newValue
        }
    }
    
    //cell 分隔线左边InsetZero
    func setSeparatorInsetZero(){
        self.separatorInset = UIEdgeInsetsZero
    }

}

extension FormBaseCell {
    
    class func fromNib<T : FormBaseCell>(nibNameOrNil: String? = nil) -> T {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            name = "\(T.self)".componentsSeparatedByString(".").last!
        }
        let nibViews = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews {
            if let tog = v as? T {
                view = tog
            }
        }
        return view!
    }
}

//extension FormBaseCell{
//    
//    override func drawRect(rect: CGRect) {
//        
//        if self.isLastCell == false {
//            
//            let line = UIBezierPath()
//            line.moveToPoint(CGPoint(x: 15, y: CGRectGetMaxY(rect)))
//            line.addLineToPoint(CGPoint(x: CGRectGetMaxX(rect), y: CGRectGetMaxY(rect)))
//            UIColor(red: 230/255.0, green: 230/255.0, blue: 240/255.0, alpha: 1).setStroke()
//            line.stroke()
//        }
//    }
//}
