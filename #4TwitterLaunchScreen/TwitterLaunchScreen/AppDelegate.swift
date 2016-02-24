//
//  AppDelegate.swift
//  TwitterLaunchScreen
//
//  Created by Henry Huang on 2/23/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1.0)
        
        guard let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else {
            return true
        }
        window?.rootViewController = navigationController
        
        // set up mask
        let maskLayer = CALayer()
        maskLayer.contents = UIImage(named: "logo")?.CGImage
        maskLayer.position = navigationController.view.center
        maskLayer.bounds = CGRectMake(0, 0, 60, 60)
        navigationController.view.layer.mask = maskLayer
        
        // set up mask background view (white view between mask and root controller)
        let maskBackgroundView = UIView(frame: navigationController.view.bounds)
        maskBackgroundView.backgroundColor = UIColor.whiteColor()
        navigationController.view.addSubview(maskBackgroundView)
        navigationController.view.bringSubviewToFront(maskBackgroundView)
        
        // set up mask animation
        let maskAnimation = CAKeyframeAnimation(keyPath: "bounds")
        maskAnimation.duration = 1.0
        maskAnimation.beginTime = CACurrentMediaTime() + 1.0
        
        let initialBounds = maskLayer.bounds
        let midBounds = CGRectMake(0, 0, 50, 50)
        let finalBounds = CGRectMake(0, 0, 3000, 3000)
        maskAnimation.values = [NSValue(CGRect: initialBounds), NSValue(CGRect: midBounds), NSValue(CGRect: finalBounds)]
        maskAnimation.keyTimes = [0.0, 0.5, 1.0]
        maskAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)]
        maskAnimation.removedOnCompletion = false
        maskAnimation.fillMode = kCAFillModeForwards
        navigationController.view.layer.mask?.addAnimation(maskAnimation, forKey: "maskAnimation")
        
        // disappear mask background view animation
        UIView.animateWithDuration(0.2, delay: 1.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            maskBackgroundView.alpha = 0.0
            }) { (Bool) -> Void in
                maskBackgroundView.removeFromSuperview()
        }
        
        // root controller animation
        UIView.animateWithDuration(0.3, delay: 1.2, options: .TransitionNone, animations: { () -> Void in
            navigationController.view.transform = CGAffineTransformMakeScale(1.05, 1.05)
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                    navigationController.view.transform = CGAffineTransformIdentity
                    }, completion: { (Bool) -> Void in
                        navigationController.view.layer.mask = nil
                })
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

