//
//  EditVideoViewController.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/21.
//

import UIKit
import Eureka
import RealmSwift

class EditVideoViewController: FormViewController {
    
    let realm = try! Realm()
    
    let partsDic = Constants.Form.partsDic
    
    let formLists = Constants.Form.formLists
    
    var video = VideoMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(video)
        form
        +++ Section("💪 Edit Workout")
        // Section
        +++ Section("General")
        <<< TextRow("name") { row in
            row.title = "name"
            row.value = video.name
            row.placeholder = "e.g Push up"
        }
        <<< IntRow("totalDuraion") { row in
            row.title = "Duration"
            row.value = video.duration
            row.placeholder = "Total Duration"
        }
        
        <<< SegmentedRow<String>("durationUnit"){
            $0.options = ["mins", "seconds"]
            $0.title = ""
            $0.value = "seconds"
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
                        switch item {
                        case "Obliques":
                            $0.value = video.obliques
                        case "Rectus":
                            $0.value = video.rectus
                        case "Back":
                            $0.value = video.back
                        case "Hips":
                            $0.value = video.hips
                        case "Adductor":
                            $0.value = video.adductor
                        case "Quadsriceps":
                            $0.value = video.quadsriceps
                        case "Trochantor":
                            $0.value = video.trochantor
                        case "Calves":
                            $0.value = video.calves
                        case "Biceps":
                            $0.value = video.biceps
                        case "Triceps":
                            $0.value = video.triceps
                        default:
                            $0.value = 0
                        }
                       
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
        do {
            try self.realm.write {
                video.name = name
                video.duration = duration

                video.biceps = dic["Biceps"]!
                video.triceps = dic["Triceps"]!

                //body
                video.back = dic["Back"]!
                video.hips = dic["Hips"]!
                video.rectus = dic["Rectus"]!
                video.obliques = dic["Obliques"]!
                video.chest = dic["Chest"]!

                //legs
                video.adductor = dic["Adductor"]!
                video.quadsriceps = dic["Quadsriceps"]!
                video.trochantor = dic["Trochantor"]!
                video.calves = dic["Calves"]!
        

                self.realm.add(video)
            }

        } catch {
            print("error")
        }
    }
    
    
}
