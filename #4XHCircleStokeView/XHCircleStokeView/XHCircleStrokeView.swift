//
//  XHCircleStrokeView.swift
//  XHCircleStokeView
//
//  Created by Henry Huang on 2/23/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class XHCircleStrokeView: UIView {

    var backColor: UIColor!
    var frontColor: UIColor!
    var fillColor: UIColor!
    var strokeWidth: CGFloat!
    var duration: Double!
    
    var circleBackgroundLayer: CAShapeLayer!
    var circleFrontLayer: CAShapeLayer!
    var timeLabel: UILabel!
    var labelEnable: Bool = true
    var glowEnabel: Bool = false
    
    var time = 5
    var clock: NSTimer?
    
    init(frame: CGRect, withDuration duration: Double, backColor: UIColor, frontColor: UIColor, fillColor: UIColor, strokeWidth: CGFloat, enableTimeLabel labelEnable: Bool, enableGlow glowEnable: Bool) {
        
        self.duration = duration
        self.backColor = backColor
        self.frontColor = frontColor
        self.fillColor = fillColor
        self.strokeWidth = strokeWidth
        self.circleBackgroundLayer = CAShapeLayer()
        self.circleFrontLayer = CAShapeLayer()
        self.timeLabel = UILabel()
        self.labelEnable = labelEnable
        self.glowEnabel = glowEnable
        
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        let circleRadius = min(frame.size.width, frame.size.height) / 2.0
        let circleCenterToSelf = CGPointMake(
            self.bounds.size.width > circleRadius ? bounds.size.width / 2.0 : circleRadius,
            self.bounds.size.height > circleRadius ? bounds.size.height / 2.0 : circleRadius)
        // setup back stroke
        circleBackgroundLayer.strokeColor = backColor.CGColor
        circleBackgroundLayer.fillColor = fillColor.CGColor
        circleBackgroundLayer.lineWidth = strokeWidth
        circleBackgroundLayer.path = UIBezierPath(ovalInRect: CGRectMake(circleCenterToSelf.x - circleRadius, circleCenterToSelf.y - circleRadius, circleRadius*2, circleRadius*2)).CGPath
        self.layer.addSublayer(circleBackgroundLayer)
        // setup front stroke
        circleFrontLayer.strokeColor = frontColor.CGColor
        circleFrontLayer.fillColor = UIColor.clearColor().CGColor
        circleFrontLayer.lineWidth = strokeWidth
        circleFrontLayer.path = UIBezierPath(arcCenter: circleCenterToSelf, radius: circleRadius, startAngle: CGFloat(-M_PI/2), endAngle: CGFloat(3*M_PI/2), clockwise: true).CGPath
        // enable glow effect
        if glowEnabel {
            circleFrontLayer.shadowColor = frontColor.CGColor
            circleFrontLayer.shadowRadius = 4.0
            circleFrontLayer.shadowOpacity = 0.9
            circleFrontLayer.shadowOffset = CGSizeZero
            circleFrontLayer.masksToBounds = false
        }
        
        self.layer.addSublayer(circleFrontLayer)
        circleFrontLayer.hidden = true
        // setup time label
        timeLabel.frame = CGRectMake(circleCenterToSelf.x - circleRadius, circleCenterToSelf.y - circleRadius, circleRadius*2, circleRadius*2)
        timeLabel.text = "\(Int(duration))"
        timeLabel.textAlignment = .Center
        timeLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 60.0)
        timeLabel.textColor = UIColor.blackColor()
        
        if labelEnable {
            self.addSubview(timeLabel)
        }
    }
    
    func reset() {
        time = Int(duration)
        timeLabel.text = "\(time)"
        clock?.invalidate()
        circleFrontLayer.removeAllAnimations()
        circleFrontLayer.hidden = true
    }
    
    func play() {
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.duration = duration
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        circleFrontLayer.hidden = false
        circleFrontLayer.addAnimation(strokeAnimation, forKey: "stroke")
        
        time = Int(duration)
        timeLabel.text = "\(time)"
        // print("\(time)")
        clock?.invalidate()
        clock = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countdown:", userInfo: nil, repeats: true)
    }
    
    func countdown(sender: AnyObject) {
        time--
        timeLabel.text = "\(time)"
        // print("\(time)")
        if time == 0 {
            clock?.invalidate()
        }
        
        
    }
}
