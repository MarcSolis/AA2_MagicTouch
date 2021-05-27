//
//  UIImage+Shapes.swift
//  MagicTouch
//
//  Created by Alumne on 25/5/21.
//

import UIKit

extension UIImage {

    class func shapeImageWithBezierPath(
        bezierPath: UIBezierPath, fillColor: UIColor?, strokeColor: UIColor?, strokeWidth: CGFloat = 0.0
    ) -> UIImage! {
        bezierPath.apply(CGAffineTransform(
                            translationX: -bezierPath.bounds.origin.x + strokeWidth,
                            y: -bezierPath.bounds.origin.y + strokeWidth))
        let size = CGSize(
            width: bezierPath.bounds.width + strokeWidth * 2,
            height: bezierPath.bounds.height + strokeWidth * 2
        )
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        var image = UIImage()
        if let context  = context {
            context.saveGState()
            context.addPath(bezierPath.cgPath)
            UIColor.black.setStroke()
            context.setLineWidth(10000)
            context.drawPath(using: .fillStroke)

            context.addPath(bezierPath.cgPath)
            if strokeColor != nil {
                strokeColor!.setStroke()
                context.setLineWidth(strokeWidth)
            } else { UIColor.clear.setStroke() }
            fillColor?.setFill()
            context.drawPath(using: .fillStroke)
             image = UIGraphicsGetImageFromCurrentImageContext()!
            context.restoreGState()
            UIGraphicsEndImageContext()
        }
        return image
    }

}
