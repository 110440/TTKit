//
//  FormDataDelegate.swift
//  testTableView
//
//  Created by tanson on 15/12/30.
//  Copyright © 2015 tanson. All rights reserved.
//

import UIKit

class FormDataDelegate: NSObject ,UITableViewDataSource,UITableViewDelegate{

    var sections:[FormSection]
    
    weak var controller:UIViewController?
    
    init(sections:[FormSection]) {
        self.sections = sections
        super.init()
    }
    
    // private
    private func cellForIndexPath(index:NSIndexPath)-> UITableViewCell{
        return self.sections[index.section].cellForRow(index.row)
    }
    
    //MARK:- UITableView Delegate -
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].cellsCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.cellForIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].headTitle 
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.sections[section].footTitle
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if let controller = self.controller as? FormHeightForSectionProtocol{
            return controller.heightForHeadSection(section)
        }
        return UITableViewAutomaticDimension
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if let controller = self.controller as? FormHeightForSectionProtocol{
            return controller.heightForFootSection(section)
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if let cell = self.cellForIndexPath(indexPath) as? FormCellCustomHeightProtocol{
            return cell.formCellHeight()
        }
        return 44.0
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = self.cellForIndexPath(indexPath) as? FormCellSelectProtocol{
            cell.formDidSelectRow(indexPath, tableView: tableView)
        }
        //
        self.focusOnCell(self.cellForIndexPath(indexPath))
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = self.cellForIndexPath(indexPath) as? FormCellDeselectProtocol {
            cell.formDidDeselectRow(indexPath, tableView: tableView)
        }
    }
    
    // MARK:-
    // 通知其它cell，有人被选中
    private func focusOnCell(_cell:UITableViewCell){
        for section in self.sections{
            var index = 0
            for cell in section.cells {
                
                if let cell = cell as? FormCellOnFoucsProtocol {
                    cell.formCellOnFoucs(_cell)
                }
                index++
            }
        }
    }
}
