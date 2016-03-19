//
//  ZoomImageScrollView.swift
//  scaleZoom
//
//  Created by tanson on 16/3/19.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

enum ZoomImageScrollViewContentMode{
    case ScaleToFit
    case ScaleToFillForWidth
}

class ZoomImageScrollView: UIScrollView , UIScrollViewDelegate {

    var imageViewContentMode:ZoomImageScrollViewContentMode = .ScaleToFit
    var clickAction:(()->Void)?
    
    lazy var imageView:UIImageView = {
        let size = self.bounds.size
        let imageView = UIImageView()
        imageView.frame = CGRectMake(0, 0, size.width, size.height)
        imageView.userInteractionEnabled = true
        self.addSubview(imageView)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.initTap()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.initTap()
    }
    
    private func initTap(){
        //let tap = UITapGestureRecognizer(target: self, action: "doubleTapScrollView:")
        //tap.numberOfTapsRequired = 2
        //self.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: "clickScrollView")
        tap2.numberOfTapsRequired = 1
        //tap2.requireGestureRecognizerToFail(tap)
        self.addGestureRecognizer(tap2)
    }
    
    func setImage(image:UIImage){
        
        self.layoutIfNeeded()
        self.zoomScale = 1
        
        self.imageView.image = image
        self.imageView.contentMode = UIViewContentMode.Center
        self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height)
        
        self.contentSize = image.size
        
        let scrollViewFrame = self.frame
        let scaleWidth = scrollViewFrame.size.width / image.size.width
        let scaleHeight = scrollViewFrame.size.height / image.size.height
        var minScale = scaleWidth
        if self.imageViewContentMode == .ScaleToFit{
            minScale = min(scaleHeight, scaleWidth)
        }
        
        // minScale > 1 意味着图片比 scrollView 要小,保持原始大小
        self.minimumZoomScale = minScale > 1 ? 1:minScale
        self.maximumZoomScale = 1.5
        self.zoomScale = minScale > 1 ? 1:minScale
        
        self.centerContentSize()
    }
    
    private func centerContentSize() {
        let boundSize = self.bounds.size
        var contentsFrame = self.imageView.frame
        
        if contentsFrame.size.width < boundSize.width {
            contentsFrame.origin.x = (boundSize.width - contentsFrame.size.width) / 2
        } else {
            contentsFrame.origin.x = 0
        }
        
        if contentsFrame.size.height < boundSize.height {
            contentsFrame.origin.y = (boundSize.height - contentsFrame.size.height) / 2
        } else {
            contentsFrame.origin.y = 0
        }
        
        self.imageView.frame = contentsFrame
    }
    
    // scrollView delegate
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        self.centerContentSize()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //Action
    @objc private func doubleTapScrollView(sender: UITapGestureRecognizer) {
        
        let minimumZoomScale = self.minimumZoomScale
        let maximumZoomScale = self.maximumZoomScale
        let boundaryScale = (maximumZoomScale - minimumZoomScale) / 2.0 + minimumZoomScale
        
        if boundaryScale > self.zoomScale {
            // Zoom in to the point tapped.
            var point = sender.locationInView(self)
            point.x /= self.zoomScale
            point.y /= self.zoomScale
            var rect = CGRect()
            rect.size.width  = self.bounds.size.width / maximumZoomScale
            rect.size.height = self.bounds.size.height / maximumZoomScale
            rect.origin.x = point.x - (rect.size.width  / 2.0)
            rect.origin.y = point.y - (rect.size.height / 2.0)
            self.zoomToRect(rect, animated: true)
            
        } else {
            // Zoom out.
            self.setZoomScale(minimumZoomScale, animated: true)
        }
    }
    @objc private func clickScrollView(){
        self.clickAction?()
    }
}
