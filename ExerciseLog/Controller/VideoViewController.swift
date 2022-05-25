//
//  VideoViewController.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/11.
//

import youtube_ios_player_helper
import UIKit
import RealmSwift

class VideoViewController: UIViewController {
    
    let realm = try! Realm()
    var videoMenu : Results <VideoMenu>?
    
    //    var videoManager = VideoManager()
    var videos = [VideoModel]()
    
//    let floatingButton = FloatingButton()
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    @IBOutlet weak var videoTableView: UITableView!
    
    @IBOutlet weak var importButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(floatingButton)
//        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchDown)
        
        videoTableView.rowHeight = 80.0
        
        playerView.load(withVideoId: "")
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
//        floatingButton.frame = CGRect(
//            x: view.frame.size.width -  70,
//            y: view.frame.size.height - 300,
//            width: 60,
//            height: 60)
    }
    
    @IBAction func importButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "gotoNewVideo", sender: self)
    }
    // MARK: - Data Manipulation Methods
    //    func save(videoMenu: VideoMenu) {
    //        do {
    //            try realm.write {
    //                if realm.object(ofType: VideoMenu.self, forPrimaryKey: videoMenu.videoId) == nil {
    //                    realm.add(videoMenu)
    //                }
    //            }
    //        } catch {
    //            print("Error saving workout menu, \(error)")
    //        }
    //
    //        tableView.reloadData()
    //    }
    
    func loadVideoMenu() {
        
        videoMenu = realm.objects(VideoMenu.self)
        videoTableView.reloadData()
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
        let selectedVideoId = videoMenu?[indexPath.row].videoId
        playerView.load(withVideoId: selectedVideoId!)
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
//            self.present(editVC, animated: true, completion: nil)
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
            
        }
    }
}


