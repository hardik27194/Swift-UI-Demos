//
//  ContainerViewController.swift
//  XHSlideMenuDemo
//
//  Created by Henry Huang on 9/22/15.
//  Copyright (c) 2015 XiaoHuang. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    // MARK: var & outlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuContainerView: UIView!
    
    private var detailViewController: DetailViewController?

    var showingMenu: Bool = false
    var detailItems: Dictionary<String, String>? {
        didSet {
            showMenu(false, animated: true)
            if let detailVC = detailViewController {
                detailVC.detailItems = detailItems
            }
        }
    }
    
    var detailColor: Array<Int>? {
        didSet {
            if let detailVC = detailViewController {
                detailVC.detaiColor = detailColor
            }
        }
    }
    
    // MARK: view
    override func viewDidLoad() {

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showMenu(showingMenu, animated: true)
        menuContainerView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    // MARK: helper function
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetaiViewSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            detailViewController = navigationController.topViewController as? DetailViewController
        }
    }
    
    func showMenu (show: Bool, animated: Bool) {
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        scrollView.setContentOffset(show ? CGPointZero : CGPointMake(menuOffset, 0), animated: animated)
        showingMenu = show
    }
    
    func transformForFraction(fraction:CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000.0;
        let angle = Double(1.0 - fraction) * -M_PI_2
        let xOffset = CGRectGetWidth(menuContainerView.bounds) * 0.5
        let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }
}

extension ContainerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame))
        let multiplier = 1.0 / CGRectGetWidth(menuContainerView.bounds)
        let offset = scrollView.contentOffset.x * multiplier
        let fraction = 1.0 - offset
        menuContainerView.layer.transform = transformForFraction(fraction)
        menuContainerView.alpha = fraction
        
        if let detailViewController = detailViewController {
            if let rotatingView = detailViewController.hamburgerView {
                rotatingView.rotate(fraction)
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        showingMenu = !CGPointEqualToPoint(CGPoint(x: menuOffset, y: 0), scrollView.contentOffset)
    }
}
