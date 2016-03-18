//
//  TTImageViewerControllerViewController.swift
//  TestAnimations
//
//  Created by tanson on 16/3/16.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class TTImageViewerItem {
    var thumbImageView:UIImageView
    var originSize:CGSize
    var originURL:NSURL?
    init(thumbImageView:UIImageView,originSize:CGSize,originURL:NSURL?){
        self.thumbImageView = thumbImageView
        self.originSize = originSize
        self.originURL  = originURL
    }
}

//MARK:- TTImageViewerController
class TTImageViewerController : UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate{
    
    var imageItems = [TTImageViewerItem]()
    var curCellIndexPath:NSIndexPath?
    
    lazy var collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal

        let size = self.view.bounds.size
        let frame = CGRect(x: -tt_pageSpace, y: 0, width: size.width + tt_pageSpace*2, height: size.height)
        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.pagingEnabled = true
        view.registerClass(TTImageViewerCell.self, forCellWithReuseIdentifier: "cell")
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.clearColor()
        return view
    }()
    
    private var pageWidth:CGFloat {
        return self.collectionView.frame.size.width
    }
    private var pageHeight:CGFloat{
        return self.collectionView.frame.size.height
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
    }
    
    init(items:[TTImageViewerItem],showPageIndex:Int){
        
        self.imageItems = items
        self.curCellIndexPath = NSIndexPath(forRow: showPageIndex, inSection: 0)
        
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.view.backgroundColor = UIColor.blackColor()
        self.collectionView.contentOffset = CGPoint(x: pageWidth * CGFloat(self.curCellIndexPath!.row), y: 0)
        self.collectionView.reloadData()
    }

    //MARK:<UICollectionViewDataSource>
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TTImageViewerCell
        cell.scrollView.zoomScale = 1

        let item = self.imageItems[indexPath.row]

        cell.setImageCellItem(item)
        
        cell.action = {
            self.curCellIndexPath = indexPath
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.pageWidth , height: self.pageHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
     return ImageViewerPresentTransition(duration: 0.25)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ImageViewerDismissTransition(duration:0.25)
    }

}
