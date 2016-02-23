//
//  DetailViewController.swift
//  Albums
//
//  Created by Henry Huang on 9/8/15.
//  Copyright (c) 2015 XiaoHuang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var singerImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    var data = Array<Dictionary<String, String>>()
    var index = 0
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("backHome", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "backHome" {
            let viewController = segue.destinationViewController as! ViewController
            viewController.data = data
            viewController.index = index
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        coverImageView.image = UIImage(named: "cover-" + data[index]["image"]!)
        singerImageView.image = UIImage(named: "avatar-" + data[index]["avatar"]!)
        singerLabel.text = data[index]["singer"]
        descriptionView.text = data[index]["text"]
        
        backButton.alpha = 0
    }
    

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        backButton.alpha = 1
        
        let scale = CGAffineTransformMakeScale(0.5, 0.5)
        let translate = CGAffineTransformMakeTranslation(-100, 0)
        backButton.transform = CGAffineTransformConcat(scale, translate)
        
        SpringAnimation.spring(0.5, animations: { () -> Void in
            let scale = CGAffineTransformMakeScale(1.0, 1.0)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.backButton.transform = CGAffineTransformConcat(scale, translate)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
