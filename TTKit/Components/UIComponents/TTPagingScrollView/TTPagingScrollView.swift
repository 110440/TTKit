//
//  TTPagingScrollView.swift
//  TTPagingScrollView
//
//  Created by tanson on 16/3/13.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

public class TTPagingScrollView: UIView {

    public typealias PageViewBuilder = (containerView:UIView,index:Int,frame:CGRect)->Void
    private var widthContraint:NSLayoutConstraint? = nil
    
    private class InternalScrollView:UIScrollView {
        override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
            return true
        }
    }
    
    public lazy var scrollView:UIScrollView! = {
        var v = InternalScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = false
        v.pagingEnabled = true
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        //v.backgroundColor = UIColor.redColor()
        return v
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    private func setup() {
        self.addSubview(self.scrollView)
        self.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1, constant: 0))
        self.widthContraint = NSLayoutConstraint(item: self.scrollView, attribute: .Width, relatedBy: .Equal, toItem: self , attribute: .Width, multiplier: 1, constant: 0)
        self.addConstraint(self.widthContraint!)
    }
    
    public func config(viewSpace space:Float = 5.0 ,edgesForExtended:Float,pageNumber:Int,pageViewBuilder:PageViewBuilder){
        
        guard pageNumber > 0 else {return}
        let internalScrollViewWidthConstant = (space * 2 + edgesForExtended * 2)
        self.widthContraint?.constant = CGFloat(-internalScrollViewWidthConstant)
        self.layoutIfNeeded()
        
        let scrollViewWidth = self.bounds.size.width - CGFloat(internalScrollViewWidthConstant)
        self.scrollView.contentSize = CGSize(width: scrollViewWidth * CGFloat(pageNumber) , height: self.bounds.size.height)
        
        for index in 0 ..< pageNumber {
            let frame = CGRect(x: CGFloat(index) * scrollViewWidth , y: 0.0, width: scrollViewWidth, height: self.bounds.size.height)
            let frame2 = CGRectInset(frame, CGFloat(space),0)
            pageViewBuilder(containerView: self.scrollView, index: index, frame:frame2 )
        }
    }
    
    public func scrollToPage(page:Int){
        self.scrollView.contentOffset = CGPoint(x: self.scrollView.bounds.size.width * CGFloat(page) , y: 0.0)
    }
}
