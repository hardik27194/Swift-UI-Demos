//
//  ViewController.swift
//  XHCircleStokeView
//
//  Created by Henry Huang on 2/23/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = 3
    var circleStrokeView: XHCircleStrokeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor(red: 61/255, green: 66/255, blue: 78/255, alpha: 1.0)
        
        let circleFrame = CGRectMake(view.center.x - 200/2, view.center.y - 200, 200, 200)
        circleStrokeView = XHCircleStrokeView(
            frame: circleFrame,
            withDuration: 5.0,
            backColor: UIColor.whiteColor(),
            frontColor: UIColor.cyanColor(),
            fillColor: UIColor.clearColor(),
            strokeWidth: 5.0,
            enableTimeLabel: true,
            enableGlow: true)
        circleStrokeView.timeLabel.font = UIFont(name: "HelveticaNeue", size: 80.0)
        circleStrokeView.timeLabel.textColor = UIColor.whiteColor()
        view.addSubview(circleStrokeView)
        
        let playButton = UIButton(frame: CGRectMake(view.center.x - 100/2, view.center.y + 50, 100, 50))
        playButton.setTitle("Play", forState: UIControlState.Normal)
        playButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        playButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 30.0)
        playButton.addTarget(self, action: "play:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(playButton)
        
        let resetButton = UIButton(frame: CGRectMake(view.center.x - 100/2, view.center.y + 110, 100, 50))
        resetButton.setTitle("Reset", forState: UIControlState.Normal)
        resetButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        resetButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 30.0)
        resetButton.addTarget(self, action: "reset:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(resetButton)
    }
    
    func play(sender: UIButton) {
        circleStrokeView.play()
    }
    
    func reset(sender: UIButton) {
        circleStrokeView.reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

