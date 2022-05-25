//
//  VideoMenu.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/19.
//

import Foundation
import RealmSwift

class VideoMenu: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var duration: Int = 0
    @objc dynamic var videoId: String = ""
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var durationString: String = ""
    
    @objc dynamic var adductor: Int = 0
    @objc dynamic var quadsriceps: Int = 0
    @objc dynamic var trochantor: Int = 0
    @objc dynamic var calves: Int = 0
    
    @objc dynamic var biceps: Int = 0
    @objc dynamic var triceps: Int = 0
    
    @objc dynamic var rectus: Int = 0
    @objc dynamic var obliques: Int = 0
    
    @objc dynamic var back: Int = 0
    @objc dynamic var hips: Int = 0
    @objc dynamic var chest: Int = 0
    
    override static func primaryKey() -> String? {
        return "videoId"
    }
}
