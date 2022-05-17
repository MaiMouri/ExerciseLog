//
//  WorkoutTableViewController.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/10.
//

import UIKit
import RealmSwift
// import SwipeCellKit

class WorkoutTableViewController:  SwipeTableViewController {
    
    let realm = try! Realm()
    //    var workouts = ["Plank", "Abduction", "Barby Jump"]
    var workoutMenu : Results <WorkoutMenu>?
    
    @IBOutlet weak var workoutAddButton: UIButton!
    
    let floatingButton = FloatingButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWorkoutMenu()
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchDown)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWorkoutMenu()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(
            x: view.frame.size.width -  70,
            y: view.frame.size.height - 300,
            width: 60,
            height: 60)
    }
    
//    Floating button function
    @objc private func didTapButton() {
        performSegue(withIdentifier: "gotoNew", sender: self)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutMenu?.count ?? 1
    }
    
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = workoutMenu?[indexPath.row].name ?? "No Workout Added yet"
        return cell
    }
    
    // MARK: - Data Manipulation Methods
    func save(workoutMenu: WorkoutMenu) {
        do {
            try realm.write {
                realm.add(workoutMenu)
            }
        } catch {
            print("Error saving workout menu, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadWorkoutMenu() {
        
        workoutMenu = realm.objects(WorkoutMenu.self)
        
        
        tableView.reloadData()
    }
    
    // MARK: - Add a new workout menu
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        var durationField = UITextField()
        var obliquesField = UITextField()
        var quadsField = UITextField()
        
        let alert = UIAlertController(title: "Add New Workout", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newWorkout = WorkoutMenu()
            newWorkout.name = textField.text!
            newWorkout.duration = Int(durationField.text ?? "") ?? 0
            newWorkout.obliques = Int(obliquesField.text ?? "") ?? 0
            newWorkout.quads = Int(quadsField.text ?? "") ?? 0
            
            //            self.workouts.append(newWorkout)
            
            self.save(workoutMenu: newWorkout)
        }
        alert.addAction(action)
        
        alert.addTextField{(field) in
            textField = field
            textField.placeholder = "Add a new workout"
            textField.returnKeyType = .next
        }
        
        alert.addTextField{(field) in
            durationField = field
            durationField.placeholder = "duration?"
            durationField.returnKeyType = .next
            durationField.keyboardType = .numberPad
        }
        
        alert.addTextField{(field) in
            obliquesField = field
            obliquesField.placeholder = "Obliques duration?"
            obliquesField.returnKeyType = .next
            obliquesField.keyboardType = .numberPad
        }
        
        alert.addTextField{(field) in
            quadsField = field
            quadsField.placeholder = "Quads duration?"
            quadsField.returnKeyType = .continue
            quadsField.keyboardType = .numberPad
        }
        
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if let workoutMenuItem = workoutMenu?[indexPath.row] {
            print(workoutMenuItem.name)
            let alert = UIAlertController(title: "Do this Workout", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Do", style: .default) { (action) in
                let workout = Workout()
                workout.name = workoutMenuItem.name
                workout.duration = workoutMenuItem.duration
                workout.obliques = workoutMenuItem.obliques
                workout.quads = workoutMenuItem.quads
                workout.dateCreated = Date()
                //                    self.save(workout: workout)
                do {
                    try self.realm.write {
                        self.realm.add(workout)
                    }
                    
                } catch {
                    print("error")
                }
            }
            alert.addAction(action)
            
            // キャンセルボタンの定義
            let cancelAction:UIAlertAction =
            UIAlertAction(title: "Cancel",
                          style: .cancel,
                          handler:{
                (action:UIAlertAction!) -> Void in
                // キャンセルボタンを押した時の処理
                print("Cancel")
            })
            
            // アラートビューへアクションを追加する
            alert.addAction(cancelAction)
            //                    alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
            
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let workoutForDeletion = self.workoutMenu?[indexPath.row] {
            do {
                try self.realm.write{
                    self.realm.delete(workoutForDeletion)
                }
            } catch {
                print("Error deleting workout, \(error)")
            }
        }
    }
 
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
