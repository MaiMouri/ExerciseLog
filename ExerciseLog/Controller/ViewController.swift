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
    let firstTarget = 100
    let secondTarget = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWorkouts()
        //        print(workouts?.count ?? "nil")
        //        print("General func today midnight: \(getDate(today: date, days: 0))")
        //        print("tomorrow: \(getDate(today: date, days: 1))")
        //        print("7days: \(getDate(today: date, days: -7))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWorkouts()
        // tableView.reloadData()
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
        let rectusDurations:Int = workouts!.sum(ofProperty: "rectus")
        let backDurations:Int = workouts!.sum(ofProperty: "back")
        let hipsDurations:Int = workouts!.sum(ofProperty: "hips")
        let chestDurations:Int = workouts!.sum(ofProperty: "chest")
        
        // Quads
        let quadsDurations:Int = workouts!.sum(ofProperty: "quads")
        let adductorDurations:Int = workouts!.sum(ofProperty: "adductor")
        let quadricepsDurations:Int = workouts!.sum(ofProperty: "quadsriceps")
        let trochantorDurations:Int = workouts!.sum(ofProperty: "trochantor")
        let calvesDurations:Int = workouts!.sum(ofProperty: "calves")
        
        // Arms
        let bicepsDurations:Int = workouts!.sum(ofProperty: "biceps")
        let tricepsDurations:Int = workouts!.sum(ofProperty: "triceps")
        
        print(obliquesDurations, quadsDurations, rectusDurations, backDurations, hipsDurations, adductorDurations, quadricepsDurations, trochantorDurations, calvesDurations, chestDurations)
        

        obliquesImage.isHidden = true
        rectusImage.isHidden = true
        backImage.isHidden = true
        chestImage.isHidden = true
        hipsImage.isHidden = true
        adductorImage.isHidden = true
        quadricepsImage.isHidden = true
        trochantorImage.isHidden = true
        calvesImage.isHidden = true
        bicepsImage.isHidden = true
        tricepsImage.isHidden = true
        
        let imageCalc = [
            "obliques":["duration": obliquesDurations, "image": obliquesLightImage!, "redImage": UIImage(named: "Obliques")! as UIImage],
            "rectus":["duration": rectusDurations, "image": rectusLightImage!, "redImage": UIImage(named: "Rectus")!],
            "hips":["duration": hipsDurations, "image": hipsLightImage!, "redImage": UIImage(named: "Hips")!],
            "back":["duration": backDurations, "image": backLightImage!, "redImage": UIImage(named: "Back")!],
            "chest":["duration": chestDurations, "image": chestLightImage!, "redImage": UIImage(named: "Chest")!],
            "trochantor":["duration": trochantorDurations, "image": trochantorLightImage!, "redImage": UIImage(named: "Trochanter")!],
            "adductor":["duration": adductorDurations, "image": adductorLightImage!, "redImage": UIImage(named: "Adductor")!],
            "quadriceps":["duration": quadricepsDurations, "image": quadricepsLightImage!, "redImage": UIImage(named: "Quadriceps")!],
            "calves":["duration": calvesDurations, "image": calvesLightImage!, "redImage": UIImage(named: "Calves")!],
            "biceps":["duration": bicepsDurations, "image": bicepsLightImage!, "redImage": UIImage(named: "Biceps")!],
            "triceps":["duration": tricepsDurations, "image": tricepsLightImage!, "redImage": UIImage(named: "Triceps")!]
        ]
        let parts = ["obliques", "rectus", "hips", "back", "adductor", "quadriceps", "trochantor", "calves", "biceps", "triceps", "chest"]

        
        parts.forEach{ part in
            changeImage(duration: imageCalc[part]!["duration"] as! Int, imageView: imageCalc[part]!["image"] as! UIImageView, redImageView: imageCalc[part]!["redImage"] as! UIImage )
        }
        
        //        tableView.reloadData()
    }
    
    func changeImage(duration: Int, imageView: UIImageView, redImageView: UIImage) {
        if 0 < duration && duration < firstTarget {
            imageView.alpha = 0.5
        } else if duration >= firstTarget && duration < secondTarget {
            imageView.alpha = 1.0
        } else if duration >= secondTarget {
            imageView.image = redImageView
        } else if duration == 0 {
            imageView.isHidden = true
        } else {
            imageView.isHidden = true
        }
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

