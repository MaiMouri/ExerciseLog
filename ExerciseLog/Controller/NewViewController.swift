//
//  NewViewController.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/15.
//

import UIKit
import Eureka
import RealmSwift

class NewViewController: FormViewController {
    
    let realm = try! Realm()
    
    let partsDic = ["body": [ "Obliques", "Rectus", "Back", "Hips"],
                    "legs": ["Adductor", "Quadsriceps", "Trochantor", "Calves"],
                    "arms": ["Biceps", "Triceps"]]
    let formLists = ["body", "legs", "arms"]
                 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form
        +++ Section("💪New Workout")
        // Section
        +++ Section("General")
        <<< TextRow("name") { row in
            row.title = "name"
            row.placeholder = "e.g. Push up"
        }
        <<< IntRow("totalDuraion") { row in
            row.title = "Duration"
            row.placeholder = "Total Duration"
        }
        
        <<< SegmentedRow<String>("durationUnit"){
            $0.options = ["分", "秒"]
            $0.title = "単位"
            $0.value = "分"
        }

        
        // Section Dynamic Form
        +++ Section("Body Parts") {
            $0.tag = "body"
        }
        +++ Section("Leg Parts") {
            $0.tag = "legs"
        }
        +++ Section("Arm Parts") {
            $0.tag = "arms"
        }

        formLists.forEach{ formList in
            if let section = self.form.sectionBy(tag: formList) {
                self.partsDic[formList]?.forEach { item in
                    section
                    <<< IntRow(item) {
                        $0.title = item //タイトル
                        $0.placeholder = "Time"
                    }
                    <<< SegmentedRow<String>("\(item)Unit"){
                        $0.options = ["mins", "seconds"]
                        $0.value = "mins"
                        
                    }
                }
            }

        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(didTapSaveButton(sender:)))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
    }
    
    //    MARK: - Data Manupulation
    
    //    Save button
    @objc func didTapSaveButton(sender: UIBarButtonItem) {
        let errors = form.validate()
        guard errors.isEmpty else {
            print("validate errors:", errors)
            return
        }
        
        let values = form.values()
        print(values)
        
        let name = values["name"] as! String
        
        //  duration Int type
        var duration = values["totalDuraion"] as? Int ?? 0
        if values["durationUnit"] as! String == "mins" {
            duration *= 60
        }
        
        
        var dic: Dictionary<String, Int> = [:]
        formLists.forEach{ formList in
            partsDic[formList]?.forEach{ item in
                let itemName = item
                dic[itemName] = values[item] as? Int ?? 0
                if values["\(item)Unit"] as! String == "mins" {
                    dic[itemName]! *= 60
                }
            }
        }
        
        
        // print(name, duration, obliques, quads, hips, back, rectus, biceps, triceps)
        
        let workoutMenu = WorkoutMenu()
        workoutMenu.name = name
        workoutMenu.duration = duration
        
        workoutMenu.biceps = dic["Biceps"]!
        workoutMenu.triceps = dic["Triceps"]!
        
        //body
        workoutMenu.back = dic["Back"]!
        workoutMenu.hips = dic["Hips"]!
        workoutMenu.rectus = dic["Rectus"]!
        workoutMenu.rectus = dic["Obliques"]!
        
        //legs
        workoutMenu.adductor = dic["Adductor"]!
        workoutMenu.quadsriceps = dic["Quadsriceps"]!
        workoutMenu.trochantor = dic["Trochantor"]!
        workoutMenu.calves = dic["Calves"]!
        
        do {
            try self.realm.write {
                self.realm.add(workoutMenu)
            }
            
        } catch {
            print("error")
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    /* to hide navigation bar*/
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        navigationController?.setNavigationBarHidden(true, animated: animated)
    //    }
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        navigationController?.setNavigationBarHidden(false, animated: animated)
    //    }
    
}
