//
//  HTTPClient.swift
//  SwiftDesignPatternDemo
//
//  Created by Henry Huang on 3/8/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class HTTPClient: NSObject {

    func getRequest(url: String) -> (AnyObject) {
        return NSData()
    }
    
    func postRequest(url: String, body: String) -> (AnyObject){
        return NSData()
    }
    
    func downloadImage(url: String) -> (UIImage) {
        let aUrl = NSURL(string: url)
        let data = NSData(contentsOfURL: aUrl!)
        let image = UIImage(data: data!)
        return image!
    }

}
