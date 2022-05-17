//
//  VideoData.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/11.
//

import Foundation

struct VideoData: Codable {
//    let title: String
    var items: [Items]
}

struct Items: Codable {
    var contentDetails: ContentDetails
}

struct ContentDetails: Codable {
    var duration: String
}

