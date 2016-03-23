//
//  ImageViewerPresentTransition.swift
//  ImageViewer
//
//  Created by Michael Brown on 07/12/2015.
//  Copyright © 2015 MailOnline. All rights reserved.
//

import UIKit

class ImageViewerPresentTransition: NSObject, UIViewControllerAnimatedTransitioning {

    
    private let duration: NSTimeInterval

    init(duration: NSTimeInterval) {
        self.duration = duration
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! TTImageViewerController
        
        // toView
        toViewController.view.frame = UIScreen.mainScreen().bounds
        container.addSubview(toViewController.view)
        
        
        let curCellIndexPath = toViewController.curCellIndexPath
        let desSnapshotView = toViewController.imageItems[curCellIndexPath!.row].thumbImageView
        
        // snapshotView
        let snapshotFrame = container.convertRect(desSnapshotView.frame, fromView:desSnapshotView.superview)
        let snapshotView = UIImageView()
        snapshotView.image = desSnapshotView.image
        snapshotView.contentMode = desSnapshotView.contentMode
        snapshotView.frame = snapshotFrame
        snapshotView.clipsToBounds = desSnapshotView.clipsToBounds
        
        container.addSubview(snapshotView)
        
        //tempView for frame
        let rect = UIScreen.mainScreen().bounds
        let tempView = TTImageViewerCell(frame: CGRect(x: 0, y: 0, width: rect.size.width+tt_pageSpace*2, height: rect.size.height))
        tempView.scrollView.imageViewContentMode = toViewController.imageViewContentMode
        tempView.scrollView.setImage(snapshotView.image!)
            
        //动画
        toViewController.view.alpha = 0
        toViewController.collectionView.hidden = true
        
        UIView.animateWithDuration(self.duration, delay: 0, options: [.CurveEaseOut], animations:  {
            toViewController.view.alpha = 1
            snapshotView.frame = tempView.scrollView.imageView.frame
            
        }) { (complate) -> Void in
            
            toViewController.collectionView.hidden = false
            snapshotView.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
    }
}

