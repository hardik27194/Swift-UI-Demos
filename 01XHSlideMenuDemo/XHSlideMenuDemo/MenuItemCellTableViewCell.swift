//
//  MenuItemCellTableViewCell.swift
//  XHSlideMenuDemo
//
//  Created by Henry Huang on 9/21/15.
//  Copyright (c) 2015 XiaoHuang. All rights reserved.
//

import UIKit

class MenuItemCellTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemImageView: UIImageView!
    
    func configureForMenuItem(menuItem: Dictionary<String,String>, menuColor: Array<Int>){
        menuItemImageView.image = UIImage(named: menuItem["image"]!)
        backgroundColor = UIColor(colorArray: menuColor)
    }
}
