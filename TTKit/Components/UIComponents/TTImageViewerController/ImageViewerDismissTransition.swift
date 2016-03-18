//
//  ImageViewerDismissTransition.swift
//  ImageViewer
//
//  Created by Michael Brown on 09/12/2015.
//  Copyright © 2015 MailOnline. All rights reserved.
//

import UIKit

class ImageViewerDismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: NSTimeInterval
    
    init(duration: NSTimeInterval) {
        self.duration = duration
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView()
        
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        toViewController.view.frame = transitionContext.finalFrameForViewController(toViewController)
        container?.addSubview(toViewController.view)
        
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! TTImageViewerController
        container?.addSubview(fromViewController.view)
        
        
        let curCellIndexPath = fromViewController.curCellIndexPath
        let desSnapshotView = fromViewController.imageItems[curCellIndexPath!.row].thumbImageView
        
        let imageCell = fromViewController.collectionView.cellForItemAtIndexPath(curCellIndexPath!) as! TTImageViewerCell
        imageCell.imageView.clipsToBounds = desSnapshotView.clipsToBounds
        imageCell.imageView.contentMode = desSnapshotView.contentMode
        
        let desFrame = TSCGRectFitWithContentMode(imageCell.imageView.frame, size:imageCell.imageView.image!.size, mode:desSnapshotView.contentMode)
        
        imageCell.imageView.frame = desFrame
        
        let frame = imageCell.scrollView.convertRect(desSnapshotView.frame, fromView: desSnapshotView.superview)
        
        UIView.animateWithDuration(self.duration, delay: 0, options: [.CurveEaseOut], animations: {
            
            fromViewController.view.backgroundColor = UIColor.clearColor()
            imageCell.imageView.frame = frame
        }) { (complate) -> Void in
            fromViewController.view.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }        
        
    }
}
