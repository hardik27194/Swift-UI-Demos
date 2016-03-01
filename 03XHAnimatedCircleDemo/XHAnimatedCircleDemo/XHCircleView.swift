//
//  XHCircleView.swift
//  XHAnimatedCircleDemo
//
//  Created by Henry Huang on 2/18/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class XHCircleView: UIView {

    var circleLayer = XHCircleLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        circleLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(circleLayer)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
