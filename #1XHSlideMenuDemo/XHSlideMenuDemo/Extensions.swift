//
//  Extensions.swift
//  XHSlideMenuDemo
//
//  Created by Henry Huang on 9/21/15.
//  Copyright (c) 2015 XiaoHuang. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    convenience init(colorArray array: Array<Int>) {
        let r = CGFloat(array[0])
        let g = CGFloat(array[1])
        let b = CGFloat(array[2])
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha:1.0)
    }
}