//
//  EditViewModel.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/16.
//

import Foundation

extension NewViewController {
    
    class ViewModel {
        
        private let workout: Workout
        
        var name: String? {
            get {
                return workout.name
            }
            set {
                workout.name = newValue ?? ""
            }
        }
        
        
        init(workout: Workout) {
            self.workout = workout
        }
    }
    
}
