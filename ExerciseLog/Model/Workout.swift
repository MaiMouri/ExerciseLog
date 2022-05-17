//
//  Workout.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/10.
//

import Foundation
import RealmSwift

class Workout: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var duration: Int = 0
    @objc dynamic var quads: Int = 0
    @objc dynamic var obliques: Int = 0
    @objc dynamic var dateCreated: Date?
}

