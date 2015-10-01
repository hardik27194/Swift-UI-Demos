//
//  Data.swift
//  Albums
//
//  Created by Henry Huang on 9/8/15.
//  Copyright (c) 2015 XiaoHuang. All rights reserved.
//

import Foundation
import UIKit

func getData() -> Array<Dictionary<String,String>> {
    
    var data = [
        [
            "album" : "Chimes of Freedeom",
            "singer": "Bob Dylan",
            "image" : "dylan",
            "avatar": "dylan",
            "background": "dylan",
            "text"  : "Bob Dylan is an American singer-songwriter, artist and writer. He has been influential in popular music and culture for more than five decades. Much of his most celebrated work dates from the 1960s when his songs chronicled social unrest, although Dylan repudiated suggestions from journalists that he was a spokesman for his generation."
        ],
        [
            "album" : "Imagine",
            "singer": "John Lennon",
            "image" : "lennon",
            "avatar": "lennon",
            "background": "lennon",
            "text"  : "John Winston Ono Lennon MBE (born John Winston Lennon; 9 October 1940 – 8 December 1980) was an English singer and songwriter who rose to worldwide fame as a co-founder of the band the Beatles, the most commercially successful band in the history of popular music. With Paul McCartney, he formed a celebrated songwriting partnership."
        ],
        [
            "album" : "Change",
            "singer": "David Bowie",
            "image" : "bowie",
            "avatar": "bowie",
            "background": "bowie",
            "text"  : "David Bowie is an English singer, songwriter, multi-instrumentalist, record producer, arranger, painter, and actor. Bowie has been an influential figure in popular music for over four decades, and is renowned as an innovator, particularly for his work in the 1970s. He is known for his distinctive baritone voice as well as the eclecticism and intellectual ambition of his work."
        ],
        [
            "album" : "Love You Live",
            "singer": "The Rolling Stones",
            "image" : "rollingstones",
            "avatar": "rollingstones",
            "background": "rollingstones",
            "text"  : "The Rolling Stones were inducted into the Rock and Roll Hall of Fame in 1989, and the UK Music Hall of Fame in 2004. Rolling Stone magazine ranked them fourth on the \"100 Greatest Artists of All Time\" list, and their estimated sales are above 200 million. They have released twenty-nine studio albums, eighteen live albums and numerous compilations."
        ]
    ]
    return data
}
