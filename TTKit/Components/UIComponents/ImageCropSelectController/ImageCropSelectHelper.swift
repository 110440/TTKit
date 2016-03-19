//
//  ImageCropSelectHelper.swift
//  TestAnimations
//
//  Created by tanson on 16/3/18.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

class ImageCropSelectHelper {
    
    class func cropImage(image:UIImage , fromScrollView:UIScrollView ,withSize:CGSize)->UIImage{
        
        let newWidth  = image.size.width * fromScrollView.zoomScale
        let newHeight = image.size.height * fromScrollView.zoomScale
        let newImage  = image.tt_imageByResizeToSize(CGSize(width: newWidth, height: newHeight))
        
        let x = fromScrollView.contentOffset.x + fromScrollView.contentInset.left
        let y = fromScrollView.contentOffset.y + fromScrollView.contentInset.top
        let cropRect = CGRect(x: x, y: y, width: withSize.width, height: withSize.height)
        return newImage.tt_imageByCropToRect(cropRect)
    }
    
    class func minimumScaleFromSize(size:CGSize , toFitTargetSize:CGSize)->CGFloat{
        let widthScale = toFitTargetSize.width / size.width
        let heightScale = toFitTargetSize.height / size.height
        return max(widthScale, heightScale)
    }
}

private extension UIImage{
    func tt_imageByResizeToSize(size:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
//        UIGraphicsBeginImageContext(size)
        self.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    func tt_imageByCropToRect(rect:CGRect)->UIImage{
        let imageRef = CGImageCreateWithImageInRect(self.CGImage, rect)
        let newImage = UIImage(CGImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        return newImage
    }
}
