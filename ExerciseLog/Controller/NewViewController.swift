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
    
    var viewModel: ViewModel!
    
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
        //      initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form
        +++ Section("💪New Workout")
        // Section2
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
        }.onChange{ row in
            let durationUnit = row.value
            print(durationUnit!)
        }
        
        // Section3
        
        +++ Section("Parts")
        
        <<< IntRow("obliquesTag") { row in
            row.title = "Obliques"
            row.placeholder = "Timeを入力"
        }
        
        <<< SegmentedRow<String>("obliquesUnit"){
            $0.options = ["分", "秒"]
            $0.title = "単位"
            $0.value = "分"
        }.onChange{ row in
            let unit = row.value
            print(unit!)
        }
        
        <<< IntRow("quadsTag") { row in
            row.title = "Quads"
            row.placeholder = "Timeを入力"
        }
        
        <<< SegmentedRow<String>("quadsUnit"){
            $0.options = ["分", "秒"]
            $0.value = "分"
        }
        
        <<< IntRow("hipsTag") { row in
            row.title = "Hips"
            row.placeholder = "Timeを入力"
        }
        
        <<< SegmentedRow<String>("hipsUnit"){
            $0.options = ["分", "秒"]
            $0.value = "分"
        }
        
        <<< IntRow("rectusTag") { row in
            row.title = "Rectus"
            row.placeholder = "Timeを入力"
        }
        
        <<< SegmentedRow<String>("rectusUnit"){
            $0.options = ["分", "秒"]
            $0.value = "分"
        }
        
        <<< IntRow("backTag") { row in
            row.title = "Back"
            row.placeholder = "Timeを入力"
        }
        
        <<< SegmentedRow<String>("backUnit"){
            $0.options = ["分", "秒"]
            $0.value = "分"
        }
        
        <<< IntRow("bicepsTag") { row in
            row.title = "Biceps"
            row.placeholder = "Timeを入力"
        }
        
        <<< SegmentedRow<String>("bicepsUnit"){
            $0.options = ["分", "秒"]
            $0.value = "分"
        }
        
        <<< IntRow("tricepsTag") { row in
            row.title = "Triceps"
            row.placeholder = "Timeを入力"
        }
        
        <<< SegmentedRow<String>("tricepsUnit"){
            $0.options = ["分", "秒"]
            $0.value = "分"
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
        
        //        duration Int type
        var duration = values["totalDuraion"] as? Int ?? 0
        if values["durationUnit"] as! String == "分" {
            duration *= 60
        }
        
        var obliques = values["obliquesTag"] as? Int ?? 0
        if values["obliquesUnit"] as! String == "分" {
            obliques *= 60
        }
        
        var quads = values["quadsTag"] as? Int ?? 0
        if values["quadsUnit"] as! String == "分" {
            quads *= 60
        }
        
        /*
        var hips = values["hipsTag"] as! Int ?? 0
        if values["hipsUnit"] as! String == "分" {
            hips *= 60
        }
        var back = values["backTag"] as! Int ?? 0
        if values["backUnit"] as! String == "分" {
            back *= 60
        }
        var rectus = values["rectusTag"] as! Int ?? 0
        if values["rectusUnit"] as! String == "分" {
            rectus *= 60
        }
        var biceps = values["bicepsTag"] as! Int ?? 0
        if values["bicepsUnit"] as! String == "分" {
            biceps *= 60
        }
        var triceps = values["tricepsTag"] as! Int ?? 0
        if values["tricepsUnit"] as! String == "分" {
            triceps *= 60
        }
        */

        print(name, duration, obliques, quads)
//        print(name, duration, obliques, quads, hips, back, rectus, biceps, triceps)
        
        let workoutMenu = WorkoutMenu()
        workoutMenu.name = name
        workoutMenu.duration = duration
        workoutMenu.obliques = obliques
        workoutMenu.quads = quads
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
