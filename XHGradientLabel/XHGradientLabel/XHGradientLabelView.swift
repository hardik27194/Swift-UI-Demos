//
//  XHGradientLabel.swift
//  XHGradientLabel
//
//  Created by Henry Huang on 2/22/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class XHGradientLabelView: UIView {

    var text: String
    var colors: [CGColor]
    var font: UIFont
    var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    init(frame: CGRect, withText text: String, andFont font: UIFont, withColors colors: [CGColor]) {
        self.text = text
        self.colors = colors
        self.font = font
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        backgroundColor = UIColor.clearColor()
        clipsToBounds = true
        
        // set up gradient layer
        gradientLayer.frame = CGRectMake(-bounds.size.width, bounds.origin.y, 3 * bounds.size.width, bounds.size.height)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        // set up gradient animation
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        let scale: Float = 1.0/3.0
        let gap = 1.0/Float(colors.count)
        var fromValue = [Float](count: colors.count, repeatedValue: 0.0)
        var toValue = [Float](count: colors.count, repeatedValue: 0.0)
        for var index = 0; index < fromValue.count; ++index {
            fromValue[fromValue.count - 1 - index] = scale - Float(index) * gap
        }
        for var index = 0; index < toValue.count; ++index {
            toValue[index] = 1 - scale + Float(index) * gap
        }
        
        gradientLayer.colors = colors
        gradientLayer.locations = fromValue
        layer.addSublayer(gradientLayer)
        
        gradientAnimation.fromValue = fromValue
        gradientAnimation.toValue = toValue

        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = Float.infinity
        gradientAnimation.removedOnCompletion = false
        gradientAnimation.fillMode = kCAFillModeForwards
        
        gradientLayer.addAnimation(gradientAnimation, forKey: nil)
        
        // set up text label
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        UIGraphicsBeginImageContext(frame.size)
        // let context = UIGraphicsGetCurrentContext()
        
        var attrs: [String: AnyObject] = [:]
        attrs[NSFontAttributeName] = font
        attrs[NSParagraphStyleAttributeName] = style
        
        text.drawInRect(bounds, withAttributes: attrs)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.clearColor().CGColor
        maskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0)
        maskLayer.contents = image.CGImage
        
        gradientLayer.mask = maskLayer
    }
}