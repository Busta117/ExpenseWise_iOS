//
//  UIImage.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 1/30/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit

public extension UIView {
    public func toImage() -> UIImage {
        UIGraphicsBeginImageContext(bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return viewImage!
    }
}

// MARK: - UIImage

public extension UIImage {
    public class func from(color: UIColor, size: CGSize = CGSize(width: 10, height: 10)) -> UIImage {
        let imageView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        imageView.backgroundColor = color
        return imageView.toImage()
    }

    public func maskImage(mask: UIImage!) -> UIImage {
        let imageReference = cgImage
        let maskReference = mask.cgImage!

        let imageMask = CGImage(maskWidth: maskReference.width,
                                height: maskReference.height,
                                bitsPerComponent: maskReference.bitsPerComponent,
                                bitsPerPixel: maskReference.bitsPerPixel,
                                bytesPerRow: maskReference.bytesPerRow,
                                provider: maskReference.dataProvider!, decode: nil, shouldInterpolate: true)

        let maskedReference = imageReference!.masking(imageMask!)

        let maskedImage = UIImage(cgImage: maskedReference!)

        return maskedImage
    }

    public func image(withTintColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)
        color.setFill()
        context.fill(rect)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    public class func from(name: String, tintColor: UIColor) -> UIImage {
        let image: UIImage = UIImage(named: name)!
        return image.image(withTintColor: tintColor)
    }

    public func imageScaled(to sizeA: CGSize) -> UIImage {
        let size = sizeA

        //        if PUUtilities.isIphone6() || PUUtilities.isIphone6Plus() {
        //            size = CGSize(width: sizeA.width*0.5, height: sizeA.height*0.5)
        //        }

        let maxLong = max(self.size.width, self.size.height)
        let relation = size.width / maxLong
        let newSize: CGSize = CGSize(width: self.size.width * relation, height: self.size.height * relation)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
