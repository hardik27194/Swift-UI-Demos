//
//  ViewController.swift
//  XHGradientLabel
//
//  Created by Henry Huang on 2/22/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var labelView0: XHGradientLabelView!
    var labelView1: XHGradientLabelView!
    var myLabelViews: [XHGradientLabelView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.darkGrayColor()
        
        let frame0 = CGRectMake(view.center.x - 300/2, view.center.y - 4*50, 300, 50)
        let colors0: [CGColor] = [
            UIColor.blackColor().CGColor,
            UIColor.whiteColor().CGColor,
            UIColor.blackColor().CGColor
        ]
        
        let frame1 = CGRectMake(view.center.x - 300/2, view.center.y + 3*50, 300, 50)
        let colors1: [CGColor] = [
            UIColor.yellowColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.orangeColor().CGColor,
            UIColor.cyanColor().CGColor,
            UIColor.redColor().CGColor,
            UIColor.yellowColor().CGColor
        ]
        
        let text = "Slide to reveal"
        let font: UIFont! = UIFont(name: "HelveticaNeue-Thin", size: 28.0)
        
        labelView0 = XHGradientLabelView(frame: frame0, withText: text, andFont: font,withColors: colors0)
        view.addSubview(labelView0)
        labelView1 = XHGradientLabelView(frame: frame1, withText: text, andFont: font,withColors: colors1)
        view.addSubview(labelView1)
        myLabelViews = [labelView0, labelView1]
        
        for labelView in myLabelViews {
            let swipe = UISwipeGestureRecognizer(target: self, action: "didSwipeUpLabel:")
            swipe.direction = .Right
            labelView.addGestureRecognizer(swipe)
        }
        
        /*
        let swipe0 = UISwipeGestureRecognizer(target: self, action: "didSwipeUpLabel:")
        swipe0.direction = .Right
        labelView0.addGestureRecognizer(swipe0)
        labelView1.addGestureRecognizer(swipe0)
        */
        /*
        let swipe1 = UISwipeGestureRecognizer(target: self, action: "didSwipeDownLabel:")
        swipe1.direction = .Right
        labelView1.addGestureRecognizer(swipe1)
        */
    }
    
    func didSwipeUpLabel(sender: UISwipeGestureRecognizer) {
        enum Direction: CGFloat {
            case Left = -1.0
            case Right = 1.0
        }
        var direction: Direction!
        var imageView: UIImageView!
        
        if sender.state == .Ended {
            let swipedLabel = sender.view
            if swipedLabel == labelView0 {
                imageView = UIImageView.init(frame: CGRectMake(view.center.x - view.frame.size.width/2, view.center.y - view.frame.size.width/2, view.frame.size.width, view.frame.size.width))
                imageView.image = UIImage(named: "vg.png")
                view.addSubview(imageView)
                direction = Direction.Left
                imageView.center.x += view.frame.size.width * direction.rawValue
            } else {
                imageView = UIImageView.init(frame: CGRectMake(view.center.x - view.frame.size.width/2, view.center.y - view.frame.size.width/2, view.frame.size.width, view.frame.size.width))
                imageView.image = UIImage(named: "aw.png")
                view.addSubview(imageView)
                direction = Direction.Right
                imageView.center.x += view.frame.size.width * direction.rawValue
            }
        }
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.labelView0.center.y -= self.view.frame.size.height
            self.labelView1.center.y += self.view.frame.size.height
            imageView.center.x -= self.view.frame.size.width * direction.rawValue
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.labelView0.center.y += self.view.frame.size.height
            self.labelView1.center.y -= self.view.frame.size.height
            imageView.center.x += self.view.frame.size.width * direction.rawValue
            }, completion: {(Bool) -> Void in
                imageView.removeFromSuperview()
        })
    }
    
    func didSwipeDownLabel(sender: UISwipeGestureRecognizer) {
        //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

