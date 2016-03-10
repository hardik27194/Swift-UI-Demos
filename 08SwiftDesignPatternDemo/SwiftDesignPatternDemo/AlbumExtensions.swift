//
//  AlbumExtensions.swift
//  SwiftDesignPatternDemo
//
//  Created by Henry Huang on 3/8/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import Foundation

extension Album {
    func ae_tableRepresentation() -> (titles: [String], values:[String]) {
        return (["Artist", "Album", "Genre", "Year"], [artist, title, genre, year])
    }
}
