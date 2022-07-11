//
//  VideoViewController.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/11.
//

import youtube_ios_player_helper
import UIKit
import RealmSwift

class VideoViewController: UIViewController, YTPlayerViewDelegate {
    
    let realm = try! Realm()
    var videoMenu : Results <VideoMenu>?
    
    var videos = [VideoModel]()
    var playingVideo = VideoMenu()
    
    var playlistId: String = ""
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    @IBOutlet weak var videoTableView: UITableView!
    
    @IBOutlet weak var importButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.rowHeight = 80.0
        
        playlistId = "PLk2hgOOTvKIiKnNxXZD-NUwhu-kYr1FFR"
        
        playerView.load(withVideoId: "")
        playerView.delegate = self
        videoTableView.dataSource = self
        videoTableView.delegate = self
        loadVideoMenu()
        videoTableView.register(UINib(nibName: "ThumbnailCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadVideoMenu()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        floatingButton.backgroundColor = UIColor(red: 150/255, green: 220/255, blue: 200/255, alpha: 1.0)
    }
    
    // Floating button function
    @objc private func didTapButton() {
        performSegue(withIdentifier: "gotoNewVideo", sender: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    @IBAction func importButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "playlistId", message: "Enter the Id", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){ (action) in
            self.playlistId = textField.text!
            self.performSegue(withIdentifier: "gotoNewVideo", sender: self)
        }
        alert.addAction(
                UIAlertAction(title: "Cancel", style: .cancel))
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "PLk2hgOOTvKIiKnNxXZD-NUwhu-kYr1FFR"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    // MARK: - Data Manipulation Methods
        func save(workout: Workout) {
            do {
                try realm.write {
                    realm.add(workout)

                }
            } catch {
                print("Error saving workout menu, \(error)")
            }
    
//            tableView.reloadData()
        }
    
    func loadVideoMenu() {
        
        videoMenu = realm.objects(VideoMenu.self)
        videoTableView.reloadData()
    }
    
    // MARK: - delegate methods
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        
        if state == YTPlayerState.playing {
            print(playingVideo.videoId)
            if let video = realm.object(ofType: VideoMenu.self, forPrimaryKey: playingVideo.videoId) {
                let workout = Workout()
                workout.name = video.name
                workout.duration = video.duration
                workout.obliques = video.obliques
//                workout.quads = video.quads
                workout.chest = video.chest
                workout.back = video.back
                workout.rectus = video.rectus
                workout.biceps = video.biceps
                workout.triceps = video.triceps
                workout.quadsriceps = video.quadsriceps
                workout.adductor = video.adductor
                workout.trochantor = video.trochantor
                workout.calves = video.calves
                workout.dateCreated = Date()
                
                self.save(workout: workout)
            }

        }

    }
    
    
}

extension VideoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoMenu?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell")! as! ThumbnailCell
        
        let video = (self.videoMenu?[indexPath.row])!
        cell.setVideoCell(video)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selctedVideo = (self.videoMenu?[indexPath.row])!
        let selectedVideoId = selctedVideo.videoId
        playerView.load(withVideoId: selectedVideoId)
        playingVideo = selctedVideo
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 編集処理
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            print("Edit Page")
            
            let selectedVideo = (self.videoMenu?[indexPath.row])!

            self.performSegue(withIdentifier: "gotoEdit", sender: selectedVideo)
            completionHandler(true)
        }
        
        // 削除処理
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            print("Delete Tapped")
            completionHandler(true)
        }
        
        // 定義したアクションをセット
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoEdit") {
            let nav = segue.destination as! UINavigationController
            let editVC = nav.topViewController as! EditVideoViewController
            editVC.video = sender as! VideoMenu
        } else if(segue.identifier == "gotoNewVideo") {
            let newVC = segue.destination as! VideoTableViewController
            newVC.playlistId = self.playlistId
        }
    }
}


