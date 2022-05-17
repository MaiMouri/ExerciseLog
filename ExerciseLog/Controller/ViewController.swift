//
//  ViewController.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/08.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    
    var workouts : Results<Workout>?
    
    @IBOutlet weak var termSegment: UISegmentedControl!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var totalDurationLabel: UILabel!
    @IBOutlet weak var quadsOnImage: UIImageView!
    
    @IBOutlet weak var chestImage: UIImageView!
    @IBOutlet weak var chestLightImage: UIImageView!
    
    @IBOutlet weak var rectusImage: UIImageView!
    @IBOutlet weak var rectusLightImage: UIImageView!
    
    @IBOutlet weak var obliquesImage: UIImageView!
    @IBOutlet weak var obliquesLightImage: UIImageView!
    
    @IBOutlet weak var adductorImage: UIImageView!
    @IBOutlet weak var adductorLightImage: UIImageView!
    
    @IBOutlet weak var quadricepsImage: UIImageView!
    @IBOutlet weak var quadricepsLightImage: UIImageView!
    @IBOutlet weak var trochantorImage: UIImageView!
    @IBOutlet weak var trochantorLightImage: UIImageView!
    
    @IBOutlet weak var bicepsImage: UIImageView!
    @IBOutlet weak var bicepsLightImage: UIImageView!
    
    
    @IBOutlet weak var backLightImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var hipsImage: UIImageView!
    @IBOutlet weak var hipsLightImage: UIImageView!
    
    
    @IBOutlet weak var tricepsImage: UIImageView!
    @IBOutlet weak var tricepsLightImage: UIImageView!
    
    @IBOutlet weak var calvesImage: UIImageView!
    @IBOutlet weak var calvesLightImage: UIImageView!
    
    let date = Date()
    var calendar = Calendar.current
    var termSegmentSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWorkouts()
        print(workouts?.count ?? "nil")
        print("General func today midnight: \(getDate(today: date, days: 0))")
        print("tomorrow: \(getDate(today: date, days: 1))")
        print("7days: \(getDate(today: date, days: -7))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWorkouts()
        //            tableView.reloadData()
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoExercise", sender: self)
    }
    
    // Select the term
    @IBAction func termSegmentSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
                case 0:
                    termSegmentSelected = 0
                    break
                case 1:
                    termSegmentSelected = -7
                    break
                default:
                    break
        }
        
        // reload the data
        loadWorkouts()
    }
    
    func loadWorkouts() {
        let term = termSegmentSelected
        let startDt = getDate(today: date, days: term)
        let endDt = getDate(today: date, days: 1)
        
        workouts = realm.objects(Workout.self).filter("dateCreated => %@ && dateCreated < %@", startDt, endDt)
        
        let workoutsDurations:Int = workouts!.sum(ofProperty: "duration")
//        print(workoutsDurations)
        let totalDuration = String(workoutsDurations / 60)
        totalDurationLabel.text = totalDuration
        
        // Obliques
        let obliquesDurations:Int = workouts!.sum(ofProperty: "obliques")
        
        // Quads
        let quadsDurations:Int = workouts!.sum(ofProperty: "quads")
        
        print(obliquesDurations, quadsDurations)
        
        if quadsDurations < 50 {
            quadsOnImage.isHidden = true
        } else {
            quadsOnImage.isHidden = false
        }
            //        tableView.reloadData()
    }
    
//    // 今日の00:00を取得
//    func getYesterday(today: Date) -> Date{
//        let startOfTheDay = self.calendar.startOfDay(for: self.date)
////        let startOfTheDay = self.calendar.date(byAdding: .day, value: 0, to: calendar.startOfDay(for: self.date))
//        return startOfTheDay
//    }
    
    // 任意の日の00:00を取得
    func getDate(today: Date, days: Int) -> Date{
        let dateMidnight = self.calendar.date(byAdding: .day, value: days, to: calendar.startOfDay(for: self.date))
        return dateMidnight!
    }
    

}

