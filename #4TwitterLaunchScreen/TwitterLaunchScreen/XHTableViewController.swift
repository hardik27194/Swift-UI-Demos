//
//  XHTableViewController.swift
//  TwitterLaunchScreen
//
//  Created by Henry Huang on 2/23/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class XHTableViewController: UITableViewController {

    let avatar: [String] = ["vg.jpg", "aw.jpg", "db.jpg", "cj.jpg"]
    let image: [String] = ["vgp.jpg", "awp.jpg", "dba.jpg", "cja.jpg"]
    let userName: [String] = ["Van Gogh", "Andy Warhol", "David Bowie", "Cui Jian"]
    let account: [String] = ["@vangogh", "@andywarhol", "@davidbowie", "@cuijian"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh:")
        // self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: "add:")
        // self.navigationItem.rightBarButtonItem?.tintColor = UIColor.lightGrayColor()
        
        self.navigationItem.title = "@twitter"
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1.0)
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1.0)
    }
    
    func add(sender: UIBarButtonItem) {
        print("New")
    }
    
    func refresh(sender: UIBarButtonItem) {
        print("Refresh")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! XHTableViewCell
        
        
        // Configure the cell...
        cell.avatarImageView.image = UIImage(named: avatar[indexPath.row])
        cell.userNameLabel.text = userName[indexPath.row]
        cell.accountLabel.text = account[indexPath.row]
        cell.contentImageView.image = UIImage(named: image[indexPath.row])
        cell.contentImageView.contentMode = .ScaleAspectFill
        cell.contentImageView.clipsToBounds = true
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
