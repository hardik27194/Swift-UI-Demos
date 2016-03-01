//
//  ViewController.swift
//  Albums
//
//  Created by Henry Huang on 9/8/15.
//  Copyright (c) 2015 XiaoHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgMaskView: UIView!
    @IBOutlet weak var headerMaskView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var maskButton: UIButton!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var singerImageView: UIImageView!
    @IBOutlet weak var shareLabelsView: UIView!
    @IBOutlet weak var wechatButton: UIImageView!
    @IBOutlet weak var facebookButton: UIImageView!
    @IBOutlet weak var weiboButton: UIImageView!
 
    // MARK: Share Button
    @IBAction func shareButtonPressed(sender: AnyObject) {
        animator.removeBehavior(snapBehavior)
        
        showMaskButton()
        shareView.hidden = false
        
        shareView.transform = CGAffineTransformMakeTranslation(0, 200)
        wechatButton.transform = CGAffineTransformMakeTranslation(0, 200)
        weiboButton.transform = CGAffineTransformMakeTranslation(0, 200)
        facebookButton.transform = CGAffineTransformMakeTranslation(0, 200)
        shareLabelsView.alpha = 0
        
        SpringAnimation.spring(0.5, animations: { () -> Void in
            self.shareView.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        SpringAnimation.springWithDelay(0.5, delay: 0.05) { () -> Void in
            self.weiboButton.transform = CGAffineTransformMakeTranslation(0, 0)
        }
        SpringAnimation.springWithDelay(0.5, delay: 0.1) { () -> Void in
            self.wechatButton.transform = CGAffineTransformMakeTranslation(0, 0)
        }
        SpringAnimation.springWithDelay(0.5, delay: 0.15) { () -> Void in
            self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 0)
        }
        SpringAnimation.springWithDelay(0.5, delay: 0.2) { () -> Void in
            self.shareLabelsView.alpha = 1
        }  
    }
    @IBAction func maskButtonPreseed(sender: AnyObject) {
        hideMaskButton()
        SpringAnimation.spring(0.5, animations: { () -> Void in
            self.shareView.transform = CGAffineTransformMakeTranslation(0, 200)
        })
        self.shareView.hidden = true
    }
    
    func hideMaskButton(){
        maskButton.alpha = 1
        SpringAnimation.spring(0.5, animations: { () -> Void in
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
            self.maskButton.alpha = 0
        })
        maskButton.hidden = false

    }
    
    func showMaskButton() {
        maskButton.hidden = false
        maskButton.alpha = 0
        SpringAnimation.spring(0.5, animations: { () -> Void in
            let scale = CGAffineTransformMakeScale(0.8, 0.8)
            let translate = CGAffineTransformMakeTranslation(0, -100)
            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
            self.maskButton.alpha = 1
        })
    }
    
    // MARK: Album Button
    @IBAction func albumButtonPressed(sender: AnyObject) {
        SpringAnimation.springWithCompletion(0.7, animations: { () -> Void in
            self.dialogView.frame = CGRectMake(0, 0, 375, 667)
            self.dialogView.layer.cornerRadius = 0
            self.coverImageView.frame = CGRectMake(0, 0, 375, 375)

            self.headerMaskView.alpha = 0
            self.shareButton.alpha = 0
            }, completion: {(Bool) -> Void in
                self.performSegueWithIdentifier("toDetail", sender: self)
                })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toDetail" {
            let viewController = segue.destinationViewController as! DetailViewController
            viewController.data = data
            viewController.index = index
        }
    }
    
    // MARK: DialogView Animation
    var animator : UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var gravityBehaviour : UIGravityBehavior!
    var snapBehavior : UISnapBehavior!
    
    @IBAction func handleGesture(sender: AnyObject) {
        let myView = dialogView
        let location = sender.locationInView(view)
        let boxLocation = sender.locationInView(dialogView)
        
        if sender.state == UIGestureRecognizerState.Began {
            animator.removeBehavior(snapBehavior)
            
            let centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(myView.bounds), boxLocation.y - CGRectGetMidY(myView.bounds));
            attachmentBehavior = UIAttachmentBehavior(item: myView, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavior.frequency = 0
            
            animator.addBehavior(attachmentBehavior)
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            attachmentBehavior.anchorPoint = location
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            animator.removeBehavior(attachmentBehavior)
            
            snapBehavior = UISnapBehavior(item: myView, snapToPoint: view.center)
            animator.addBehavior(snapBehavior)
            
            let translation = sender.translationInView(view)
            if translation.y > 100 {
                animator.removeAllBehaviors()
                
                let gravity = UIGravityBehavior(items: [dialogView])
                gravity.gravityDirection = CGVectorMake(0, 10)
                animator.addBehavior(gravity)
                
                delay(0.3) {
                    self.refreshView()
                }
            }
        }
    }
    
    func refreshView() {
        index += 1
        if index == 4 { index = 0}
        
        animator.removeAllBehaviors()
        
        snapBehavior = UISnapBehavior(item: dialogView, snapToPoint: view.center)
        attachmentBehavior.anchorPoint = view.center
        
        dialogView.center = view.center
        viewDidAppear(true)
    }
    
    // MARK: Load View
    var data = getData()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        insertBlurView(bgMaskView, style: UIBlurEffectStyle.Dark)
        insertBlurView(headerMaskView, style: UIBlurEffectStyle.Dark)
        
        animator = UIDynamicAnimator(referenceView: view)
        
        dialogView.alpha = 0
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(Bool())
        
        let scale = CGAffineTransformMakeScale(0.3, 0.3)
        let translate = CGAffineTransformMakeTranslation(0, -300)
        dialogView.transform = CGAffineTransformConcat(scale, translate)
        
        SpringAnimation.spring(0.5, animations: { () -> Void in
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
        })
        
        albumLabel.text = data[index]["album"]
        singerLabel.text = data[index]["singer"]
        backgroundImageView.image = UIImage(named: "big-cover-" + data[index]["background"]!)
        singerImageView.image = UIImage(named: "avatar-" + data[index]["avatar"]!)
        coverImageView.image = UIImage(named: "cover-" + data[index]["image"]!)
        
        dialogView.alpha = 1
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

