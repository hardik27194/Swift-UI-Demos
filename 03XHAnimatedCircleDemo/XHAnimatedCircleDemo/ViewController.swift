//
//  ViewController.swift
//  XHAnimatedCircleDemo
//
//  Created by Henry Huang on 2/18/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    private var circleView: XHCircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleView = XHCircleView(frame: CGRectMake(view.frame.size.width/2 - 320/2, view.frame.size.height/2 - 320/2, 320, 320))
        view.addSubview(circleView)
        
        circleView.circleLayer.progress = CGFloat(slider.value)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didValueChanged(sender: AnyObject) {
        if let slider = sender as? UISlider {
            progressLabel.text = "Current: \(slider.value)"
            circleView.circleLayer.progress = CGFloat(slider.value)
        }
    }
    


}

