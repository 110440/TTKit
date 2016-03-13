//
//  CirCleView.swift
//  TestAnimations
//
//  Created by tanson on 16/3/4.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class CirCleView:UIView , UIScrollViewDelegate {
    
    private var timer:NSTimer?
    
    private lazy var contentScrollView:UIScrollView = {
        let scrollView = UIScrollView(frame:self.bounds )
        scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, 0)
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.pagingEnabled = true
        scrollView.backgroundColor = UIColor.greenColor()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var firstPageView:UIImageView = {
        let view = UIImageView(frame: self.bounds)
        view.userInteractionEnabled = true
        view.clipsToBounds = true
        view.contentMode = .ScaleAspectFill
        return view
    }()
    
    private lazy var secondPageView:UIImageView = {
        let size = self.frame.size
        let view = UIImageView(frame: CGRect(x: size.width, y: 0, width: size.width, height: size.height))
        view.userInteractionEnabled = true
        view.clipsToBounds = true
        view.contentMode = .ScaleAspectFill
        let tap = UITapGestureRecognizer(target: self, action:"pageViewTapAction")
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var thirdPageView:UIImageView = {
        let size = self.frame.size
        let view = UIImageView(frame: CGRect(x: size.width*2, y: 0, width: size.width, height: size.height))
        view.userInteractionEnabled = true
        view.clipsToBounds = true
        view.contentMode = .ScaleAspectFill
        return view
    }()
    
    private lazy var pageCtl:UIPageControl = {
        let h = CGFloat(30)
        let rect = CGRect(x: 0, y: self.bounds.size.height - h , width: self.bounds.size.width, height: h)
        let ctl = UIPageControl(frame: rect)
        return ctl
    }()
    
    weak var dataSource:CirCleViewDataSource?
    weak var delegate:CirCleViewDelegate?
    
    private var count:Int {
        return self.dataSource!.cirCleViewNumberOfPage(self)
    }
    
    var currentIndex:Int = 0
    
    private var firstIndex:Int {
        let idx = self.currentIndex - 1
        return idx >= 0 ? idx:(count - 1)
    }
    
    private var secondIndex:Int {
        return self.currentIndex
    }
    
    private var thirdIndex:Int {
        let idx = self.currentIndex + 1
        return idx < count ? idx:0
    }
    
    init(frame: CGRect , dataSource:CirCleViewDataSource) {
        self.dataSource = dataSource
        super.init(frame: frame)
        self.addSubview(self.contentScrollView)
        self.contentScrollView.addSubview(firstPageView)
        self.contentScrollView.addSubview(secondPageView)
        self.contentScrollView.addSubview(thirdPageView)
        self.reloadData()
        self.createTimer()
        
        self.addSubview(self.pageCtl)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTimer(){
        self.timer = NSTimer.tt_circle_scheduledTimerWithTimeInterval(2,repeats: true) { (timer) -> Void in
            self.onTimer()
        }
    }
    
    private func reloadData(){
        
        guard let dataSource = self.dataSource else { print("请设置circle dataSource ");return}
        let count = self.count ; if count <= 0 {return}
        
        // 只有一个页面时
        if count == 1 {
            dataSource.cirCleView(self, willShowView: self.firstPageView, forIndex: 0)
            self.contentScrollView.contentSize = self.bounds.size
            return
        }
        
        self.contentScrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, 0)
        self.contentScrollView.setContentOffset(CGPoint(x:self.bounds.size.width,y:0), animated: false)
        
        dataSource.cirCleView(self, willShowView: self.firstPageView , forIndex: firstIndex)
        dataSource.cirCleView(self, willShowView: self.secondPageView, forIndex: secondIndex)
        dataSource.cirCleView(self, willShowView: self.thirdPageView , forIndex: thirdIndex)
        
        //
        self.pageCtl.numberOfPages = self.count
        self.pageCtl.currentPage = self.currentIndex
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.timer?.invalidate()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x
        if offset == 0 {
            self.currentIndex = self.firstIndex
        }else if offset == self.frame.size.width*2 {
            self.currentIndex = self.thirdIndex
        }else{
            self.currentIndex = self.secondIndex
        }
        self.reloadData()
        self.createTimer()
    }
    
    // setContentOffset 动画true，会触发的方法
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.currentIndex = self.thirdIndex
        self.delegate?.cirCleView?(self, didShowPageIndex: self.currentIndex)
        self.reloadData()
    }
    
    //MARK: action
    @objc
    func pageViewTapAction(){
        self.delegate?.cirCleViewPageViewTap(self, tapIndex: self.currentIndex)
    }
    
    private func onTimer(){
        self.contentScrollView.setContentOffset(CGPoint(x:self.bounds.size.width*2,y:0), animated: true)
    }
    
}

//MARK:- protocol
@objc protocol CirCleViewDelegate {
    func cirCleViewPageViewTap(cirCleView:CirCleView,tapIndex: Int)
    optional func cirCleView(cirCleView:CirCleView,didShowPageIndex:Int)
}

@objc protocol CirCleViewDataSource{
    func cirCleViewNumberOfPage(cirCleView:CirCleView)->Int
    func cirCleView(cirCleView:CirCleView , willShowView:UIImageView , forIndex:Int)->Void
}
