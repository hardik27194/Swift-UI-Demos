//
//  XHTableViewCell.swift
//  TwitterLaunchScreen
//
//  Created by Henry Huang on 2/23/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class XHTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
