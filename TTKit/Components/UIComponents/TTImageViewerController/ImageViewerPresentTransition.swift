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
        
        //动画
        toViewController.view.alpha = 0
        toViewController.collectionView.hidden = true
        
        UIView.animateWithDuration(self.duration, delay: 0, options: [.CurveEaseOut], animations:  {
            toViewController.view.alpha = 1
            
            //ScaleAspectFit
            let originSize = toViewController.imageItems[curCellIndexPath!.row].originSize
            var desFrame = imageViewFrameForScaleByOriginSize(originSize)
            desFrame = TSCGRectFitWithContentMode(desFrame, size: originSize, mode: .ScaleAspectFit)
            snapshotView.frame = desFrame
            
        }) { (complate) -> Void in
            
            toViewController.collectionView.hidden = false
            snapshotView.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
    }
}

