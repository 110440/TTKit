//
//  UITabBarController+TT.swift
//  TTKit
//
//  Created by tanson on 16/3/16.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarController{
    
    
    func centerTabBarItemImage(){
        
        for item in self.tabBar.items!{
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 100)
        }
    }
    
    
    func addCustomButtonAt(index:Int,buttonImage:UIImage,action:CKControlHandler){
        
        let placeholderController = UIViewController()
        placeholderController.tabBarItem.image = buttonImage
        self.viewControllers?.insert(placeholderController, atIndex: index)
        
        let placeholderTabItem = self.tabBar.items![index]
        placeholderTabItem.enabled = false
        
        let views = self.tabBar.subviews.sort{ $1.frame.origin.x > $0.frame.origin.x }
        let placeholderView = views[index]
        placeholderView.hidden = true
        
        let customButton = UIButton()
        customButton.frame = placeholderView.frame
        customButton.setImage(buttonImage, forState: .Normal)
        self.tabBar.addSubview(customButton)
        self.tabBar.bringSubviewToFront(customButton)
        customButton.addEventHandler(forControlEvents: .TouchUpInside, handler: action)
    }
}