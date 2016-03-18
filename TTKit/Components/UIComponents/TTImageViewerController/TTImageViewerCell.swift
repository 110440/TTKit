//
//  TTImageViewerCell.swift
//  TestAnimations
//
//  Created by tanson on 16/3/17.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit
//import Kingfisher

let tt_pageSpace:CGFloat = 5

//将图片大小缩放，以屏幕宽度比列缩放
func imageViewFrameForScaleByOriginSize(originSize:CGSize)->CGRect{
    
    let screentSize = UIScreen.mainScreen().bounds.size
    let imageViewWidth = min(screentSize.width, originSize.width)
    let scale = originSize.width / imageViewWidth
    let imageViewHeight = max( originSize.height / scale , screentSize.height)
    
    return CGRect(x: (screentSize.width - imageViewWidth)/2, y: 0, width: imageViewWidth, height: imageViewHeight)
}

class TTImageViewerCell: UICollectionViewCell,UIScrollViewDelegate {
    
    var imageView:UIImageView = {
        let view = UIImageView()
        view.contentMode = .ScaleAspectFit
        return view
    }()
    
    func setImageCellItem(item:TTImageViewerItem){
        let frame = imageViewFrameForScaleByOriginSize(item.originSize)
        self.imageView.frame = frame
        self.scrollView.contentSize = CGSize(width: frame.size.width, height: frame.size.height)
        self.imageView.image = item.thumbImageView.image
        /*
        if let url = item.originURL{
            self.imageView.kf_setImageWithURL(url, placeholderImage: item.thumbImageView.image)
        }else{
            self.imageView.image = item.thumbImageView.image
        }*/
    }
    
    var action:(()->Void)?
    
    lazy var scrollView:UIScrollView = {
       let view = UIScrollView()
        view.maximumZoomScale = 2.0
        view.minimumZoomScale = 1.0
        view.multipleTouchEnabled = true
        view.bouncesZoom = true
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clearColor()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.scrollView)
        self.scrollView.addSubview(self.imageView)
        
        self.contentView.addConstraint(NSLayoutConstraint(item:self.scrollView, attribute:.Top, relatedBy:.Equal, toItem:self.contentView, attribute: .Top, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item:self.scrollView, attribute:.Left, relatedBy:.Equal, toItem:self.contentView, attribute: .Left, multiplier: 1, constant: tt_pageSpace))
        self.contentView.addConstraint(NSLayoutConstraint(item:self.scrollView, attribute:.Bottom, relatedBy:.Equal, toItem:self.contentView, attribute: .Bottom, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item:self.scrollView, attribute:.Right, relatedBy:.Equal, toItem:self.contentView, attribute:.Right, multiplier: 1, constant: tt_pageSpace))
        
        let tap = UITapGestureRecognizer(target: self, action: "tap")
        self.scrollView.addGestureRecognizer(tap)
    }
    
    func tap(){
        self.action?()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // scrollerViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}

