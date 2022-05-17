//
//  WorkoutViewController.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/10.
//

import UIKit
import FSCalendar
import Realm
import RealmSwift

class CalendarViewController: UIViewController, FSCalendarDataSource,FSCalendarDelegate {
//    ここでRealmからその日のメニューを呼び出す(predicate必要)

    let realm = try! Realm()
    var daysWorkout : Results <Workout>?
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var dayTableView: UITableView!
    @IBOutlet weak var labelDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        dayTableView.delegate = self
        dayTableView.dataSource = self
        loadWorkout()
        configureTableView()

    }
    
    
    // Private
    func configureTableView() {
        print("Calendar")
        //        //dataSourceとdelegateメソッドが使えるように。
        //        diaryTitleTableView.delegate = self
        //        diaryTitleTableView.dataSource = self
        //
        //        //セルの高さを30.0で固定
        //        diaryTitleTableView.rowHeight = 30.0
        //
        //        //余白を消す
        //        diaryTitleTableView.tableFooterView = UIView()
    }

    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateString = getDateString(date: date)[0]
        let nextDay = getDateString(date: date)[1]
        labelDate.text = dateString
        
        let dt = getEndOfTheDay(dateString: nextDay)

        // 日付型の値を直接表示
        print(date,dt)
        
        daysWorkout = realm.objects(Workout.self).filter("dateCreated => %@ && dateCreated < %@", date, dt)
        dayTableView.reloadData()
    }
    
    //  Get the day and the next day date as a string
    func getDateString(date: Date) -> [String] {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        
        // The day
        let dateString = "\(year)/\(month)/\(day)"
        // The next day
        let nextDayDateString = "\(year)/\(month)/\(day+1)"
        // The previous day
        let previousDayDateString = "\(year)/\(month)/\(day-1)"
        
        return [ dateString, nextDayDateString, previousDayDateString ]
    }


    func getEndOfTheDay(dateString: String) -> Date {
        // 日時に変換したい文字列を準備
        let dtStr = "\(dateString) 00:00:00"

        // DateFormatter のインスタンスを作成
        let formatter: DateFormatter = DateFormatter()

        // 日付の書式を文字列に合わせて設定
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"

        // 日時文字列からDate型の日付を生成する
        let dt : Date  = formatter.date(from: dtStr)!
        
        //日付型にした翌日0:00を返す
        return dt
    }
    
    // Display the days's workout
    func loadWorkout() {
        let date = Date()
        // Get start of the day
        let startDateString = getDateString(date: date)[0]
        let startDt = getEndOfTheDay(dateString: startDateString)
        // Get end of the day
        let dateString = getDateString(date: date)[1]
        let dt = getEndOfTheDay(dateString: dateString)

        daysWorkout = realm.objects(Workout.self).filter("dateCreated => %@ && dateCreated < %@", startDt, dt)
//        print(daysWorkout, date, dt)
    }

    
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysWorkout?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell")!
        
        cell.textLabel?.text = daysWorkout?[indexPath.row].name ?? "No Workout Added"
        
        return cell
    }
    

    // MARK: - TableView DataSource

}


