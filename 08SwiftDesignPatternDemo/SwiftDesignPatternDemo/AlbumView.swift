//
//  AlbumView.swift
//  SwiftDesignPatternDemo
//
//  Created by Henry Huang on 3/8/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class AlbumView: UIView {

    private var coverImage: UIImageView!
    private var indicator: UIActivityIndicatorView!
    
    
    init(frame: CGRect, albumCover: String) {

        super.init(frame: frame)
        
        backgroundColor = UIColor.blackColor()
        coverImage = UIImageView(frame: CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10))
        self.addSubview(coverImage)
        
        coverImage.addObserver(self, forKeyPath: "image", options: NSKeyValueObservingOptions([.New, .Old]), context: nil)
        
        indicator = UIActivityIndicatorView()
        indicator.center = self.center
        indicator.activityIndicatorViewStyle = .WhiteLarge
        indicator.startAnimating()
        self.addSubview(indicator)
        
        NSNotificationCenter.defaultCenter().postNotificationName("BLDownloadImageNotification", object: self, userInfo: ["imageView":coverImage, "coverUrl" : albumCover])
    }
    
    deinit {
        coverImage.removeObserver(self, forKeyPath: "image")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "image" {
            indicator.stopAnimating()
        }
    }
    
    func highlightAlbum(didHighlightView: Bool) {
        if didHighlightView {
            backgroundColor = UIColor.whiteColor()
        } else {
            backgroundColor = UIColor.blackColor()
        }
    }

}
