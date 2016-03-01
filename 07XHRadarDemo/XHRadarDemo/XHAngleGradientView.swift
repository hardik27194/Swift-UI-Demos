//
//  XHAngleGrandientView.swift
//  XHAngleGradientView
//
//  Created by Henry Huang on 2/26/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class XHAngleGradientView: UIView {
    
    var colors: [UIColor] = []
    
    enum Shape {
        case Oval
        case Rect
    }
    
    override class func layerClass() -> AnyClass {
        return XHAngleGrandientLayer.classForCoder()
    }
    
    init(frame: CGRect, withColors colors: [UIColor], withLocations locations: [Double], shape: Shape) {
        super.init(frame: frame)
        
        self.colors = colors

        let layer = self.layer as! XHAngleGrandientLayer
        layer.colors = colors
        layer.locations = locations
        
        // Since the gradient layer is built as an image,
        // need to scale it to match the display of the device.
        layer.contentsScale = UIScreen.mainScreen().scale
        
        if shape == .Oval {
            layer.cornerRadius = CGRectGetWidth(self.bounds) / 2
        }
        
        // other setups
        self.backgroundColor = UIColor.clearColor()
        self.opaque = false
        self.clipsToBounds = true
        self.userInteractionEnabled = false
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
