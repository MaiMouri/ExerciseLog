//
//  WorkoutMenu.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/13.
//

// Workiout Menu - List of workout

import Foundation
import RealmSwift

class WorkoutMenu: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var duration: Int = 0
    @objc dynamic var quads: Int = 0
    @objc dynamic var obliques: Int = 0
//    let date: Date
}
