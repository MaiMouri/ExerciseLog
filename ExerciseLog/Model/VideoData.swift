//
//  VideoData.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/11.
//

import Foundation

struct VideoData: Codable {
    var items: [Items]
}

struct Items: Codable {
    var contentDetails: ContentDetails
    var snippet: Snippet
    var id: String
}

struct ContentDetails: Codable {
    var duration: String
}

struct Snippet: Codable {
    var title: String
    var thumbnails: Thumbnails
}

struct Thumbnails: Codable {
    var `default`: Default
}

struct Default: Codable {
    var url: String
}

