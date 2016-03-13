//
//  FormUtils.swift
//  testTableView
//
//  Created by tanson on 16/2/17.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func form_cell() -> UITableViewCell? {
        var viewOrNil: UIView? = self
        while let view = viewOrNil {
            if let cell = view as? UITableViewCell {
                return cell
            }
            viewOrNil = view.superview
        }
        return nil
    }
}

extension UIView {
    func form_firstResponder() -> UIView? {
        if self.isFirstResponder() {
            return self
        }
        for subview in subviews {
            let responder = subview.form_firstResponder()
            if responder != nil {
                return responder
            }
        }
        return nil
    }
}

// MARK:- String Regex

extension String{
    
    func form_matchesRegex(pattern:String)->Bool{
        do{
            let regex = try NSRegularExpression(pattern: pattern,options: .CaseInsensitive)
            let number =  regex.numberOfMatchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))
            return number > 0
        }catch{
            return false
        }
    }
}

typealias FormValidator = ()->FormValidateResult
