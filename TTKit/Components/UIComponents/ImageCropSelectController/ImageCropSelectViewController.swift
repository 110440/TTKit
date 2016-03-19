//
//  ImageCropSelectViewController.swift
//  TestAnimations
//
//  Created by tanson on 16/3/18.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

class ImageCropSelectViewController:UIViewController , UIScrollViewDelegate{
    
    var action:((image:UIImage)->Void)?
    var image:UIImage
    var cropRect:CGRect
    
    var defaultScale:CGFloat {
        return ImageCropSelectHelper.minimumScaleFromSize(self.image.size, toFitTargetSize: UIScreen.mainScreen().bounds.size)
    }
    
    var minimumScale:CGFloat {
        return ImageCropSelectHelper.minimumScaleFromSize(self.image.size, toFitTargetSize: self.cropRect.size)
    }
    
    var maximumScale:CGFloat {
        return self.defaultScale * 2
    }
    
    lazy var overlayView:ImageCropSelectMarkView = {
        let view = ImageCropSelectMarkView(style:.Rectangle , rect: self.cropRect)
        view.backgroundColor = UIColor.clearColor()
        view.userInteractionEnabled = false

        return view
    }()
    
    lazy var imageView:UIImageView = {
        let view = UIImageView(image: self.image)
        return view
    }()
    
    lazy var scrollView:UIScrollView = {
        let view = UIScrollView()
        view.maximumZoomScale = self.maximumScale
        view.minimumZoomScale = self.minimumScale
        view.zoomScale = self.defaultScale
        view.delegate = self
        view.addSubview(self.imageView)
        view.contentSize = self.image.size
        view.bounces = false
        //contenInset
        let screenSize  = UIScreen.mainScreen().bounds.size
        let top         = self.cropRect.origin.y
        let left        = self.cropRect.origin.x
        let bottom      = screenSize.height - self.cropRect.size.height - top
        let right       = screenSize.width - self.cropRect.size.width - left
        view.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return view
    }()
    
    init(cropSize size:CGSize, image:UIImage){
        
        let x = (UIScreen.mainScreen().bounds.size.width - size.width)/2
        let y = (UIScreen.mainScreen().bounds.size.height - size.height)/2
        
        self.cropRect = CGRect(x: x, y: y, width: size.width, height: size.height)
        self.image = image
        
        super.init(nibName: nil, bundle: nil)
        self.initScrollView()
        self.initOverlayView()
        self.initToobarView()
    }
    
    private func initScrollView(){
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item:self.scrollView, attribute:.Top, relatedBy:.Equal, toItem:self.view, attribute: .Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item:self.scrollView, attribute:.Left, relatedBy:.Equal, toItem:self.view, attribute: .Left, multiplier: 1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(item:self.scrollView, attribute:.Bottom, relatedBy:.Equal, toItem:self.view, attribute: .Bottom, multiplier: 1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(item:self.scrollView, attribute:.Right, relatedBy:.Equal, toItem:self.view, attribute:.Right, multiplier: 1, constant: 0))
    }
    
    private func initOverlayView(){
        self.view.addSubview(self.overlayView)
        self.overlayView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item:self.overlayView, attribute:.Top, relatedBy:.Equal, toItem:self.view, attribute: .Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item:self.overlayView, attribute:.Left, relatedBy:.Equal, toItem:self.view, attribute: .Left, multiplier: 1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(item:self.overlayView, attribute:.Bottom, relatedBy:.Equal, toItem:self.view, attribute: .Bottom, multiplier: 1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(item:self.overlayView, attribute:.Right, relatedBy:.Equal, toItem:self.view, attribute:.Right, multiplier: 1, constant: 0))
        self.overlayView.setNeedsDisplay()
    }
    
    private func initToobarView(){
        let toolbar = UIToolbar()
        toolbar.barStyle = .Black
        toolbar.tintColor = UIColor.whiteColor()
        let cancelledBtn = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "cancelled")
        let cropBtn = UIBarButtonItem(title: "确定", style: .Plain, target: self, action: "crop")
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action:"")
        toolbar.items = [cancelledBtn,space,cropBtn]
            
        self.view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(NSLayoutConstraint(item:toolbar, attribute:.Left, relatedBy:.Equal, toItem:self.view, attribute: .Left, multiplier: 1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(item:toolbar, attribute:.Bottom, relatedBy:.Equal, toItem:self.view, attribute: .Bottom, multiplier: 1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(item:toolbar, attribute:.Right, relatedBy:.Equal, toItem:self.view, attribute:.Right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item:toolbar, attribute:.Height, relatedBy:.Equal, toItem:nil, attribute: .Height, multiplier: 1, constant: 48))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        
        if self.image.size.width < self.cropRect.size.width || self.image.size.height < self.cropRect.size.height{
            self.scrollView.zoomScale = self.minimumScale
        }
        let screentSize = UIScreen.mainScreen().bounds.size
        if self.image.size.width > screentSize.width || self.image.size.height > screentSize.height{
            let widthScale = screentSize.width / self.image.size.width
            let heightScale = screentSize.height / self.image.size.height
            let scale =  min(widthScale, heightScale)
            self.scrollView.zoomScale = scale
        }
        
    }
    
    //MARK:- Action
    func cancelled(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func crop(){
        let image = ImageCropSelectHelper.cropImage(self.image, fromScrollView: self.scrollView, withSize: self.cropRect.size)
        self.action?(image:image)
    }
    
    //scrollView delegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    

}