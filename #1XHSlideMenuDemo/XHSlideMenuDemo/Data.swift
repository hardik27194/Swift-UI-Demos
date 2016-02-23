//
//  Data.swift
//  XHSlideMenuDemo
//
//  Created by Henry Huang on 9/21/15.
//  Copyright (c) 2015 XiaoHuang. All rights reserved.
//

import UIKit

    func getItems() -> Array<Dictionary<String, String>> {
        let data = [["image": "People", "bigImage": "PeopleBig", "color": "People",],
                    ["image": "Book", "bigImage": "BookBig", "color": "Book",],
                    ["image": "Game", "bigImage": "GameBig", "color": "Game",],
                    ["image": "Sports", "bigImage": "SportsBig", "color": "Sports",],
                    ["image": "Cloud", "bigImage": "CloudBig", "color": "Cloud",],
                    ["image": "Email", "bigImage": "EmailBig", "color": "Email",],
                    ["image": "Eye", "bigImage": "EyeBig", "color": "Eye"]]
        return data
    }
    
    func getColor() -> Dictionary<String, Array<Int>> {
        let color = ["People": [233, 69, 60], "Book": [250, 188, 45], "Game": [57, 160, 84], "Sports": [59, 132, 246], "Cloud": [14, 88, 149], "Email": [207, 34, 156], "Eye": [69, 59, 55]]
        return color
    }