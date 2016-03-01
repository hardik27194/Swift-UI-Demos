//
//  MenuTableViewController.swift
//  XHSlideMenuDemo
//
//  Created by Henry Huang on 9/21/15.
//  Copyright (c) 2015 XiaoHuang. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    // MARK: var & outlet
    var menuItems: Array<Dictionary<String, String>>  = getItems()
    var menuColors: Dictionary<String, Array<Int>> = getColor()
    
    // view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.clipsToBounds = true
        
        (navigationController!.parentViewController as! ContainerViewController).detailItems = menuItems[0] as Dictionary
        (navigationController!.parentViewController as! ContainerViewController).detailColor = menuColors[menuItems[0]["color"]!]
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let detailItems = menuItems[indexPath.row] as Dictionary
        let detailColor = menuColors[menuItems[indexPath.row]["color"]!]
        (navigationController!.parentViewController as! ContainerViewController).detailItems = detailItems
        (navigationController!.parentViewController as! ContainerViewController).detailColor = detailColor
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return max(80, CGRectGetHeight(view.bounds) / CGFloat(menuItems.count))
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell") as! MenuItemCellTableViewCell
        let menuItem = menuItems[indexPath.row] as Dictionary
        let cellColor = menuColors[menuItems[indexPath.row]["color"]!]
        cell.configureForMenuItem(menuItem, menuColor: cellColor!)
        return cell
    }
}
