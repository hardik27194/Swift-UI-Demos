//
//  DetailViewController.swift
//  XHSlideMenuDemo
//
//  Created by Henry Huang on 9/21/15.
//  Copyright (c) 2015 XiaoHuang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: var & outlet
    @IBOutlet weak var detailImage: UIImageView!
    var hamburgerView: HamburgurView?
    
    var detailItems: Dictionary<String, String>? {
        didSet {
            if let detailItems = detailItems {
                detailImage.image = UIImage(named: detailItems["bigImage"]!)
            }
        }
    }
    var detaiColor: Array<Int>? {
        didSet {
            if let color = detaiColor {
                view.backgroundColor = UIColor(colorArray: color)
            }
        }
    }
    
    // MARK: view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hamburgerViewTapped")
        hamburgerView = HamburgurView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView?.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
        
        // remove the drop shadow from the nav bar
        navigationController!.navigationBar.clipsToBounds = true
    }
    
    func hamburgerViewTapped() {
        let navigationController = parentViewController as! UINavigationController
        let containerViewController = navigationController.parentViewController as! ContainerViewController
        containerViewController.showMenu(!containerViewController.showingMenu, animated: true)
    }
}
