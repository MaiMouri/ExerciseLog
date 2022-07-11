//
//  VideoTableViewController.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/11.
//

import UIKit
import Realm
import RealmSwift

class VideoTableViewController: UITableViewController, VideoManagerDelegate {
    
    var videos = [VideoModel]()
    var videoManager = VideoManager()
    
    let realm = try! Realm()
    
    let videoTableViewCell = VideoTableViewCell()
    
    var playlistId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoManager.delegate = self
        videoManager.fetchVideoList(with: playlistId)
        //        loadVideoMenu()
    }
    
    func videosFetched(_ videos: [VideoModel]) {
        self.videos = videos
        print("YouTube PlayList fetched")
        tableView.reloadData()
    }
    
    // MARK: - Data Manipulation Methods
    func save(videoMenu: VideoMenu) {
        do {
            try realm.write {
                if realm.object(ofType: VideoMenu.self, forPrimaryKey: videoMenu.videoId) == nil {
                    realm.add(videoMenu)
                }
            }
        } catch {
            print("Error saving workout menu, \(error)")
        }
        
        tableView.reloadData()
    }
    
    //        func loadVideoMenu() {
    //
    //            videoMenu = realm.objects(VideoMenu.self)
    //            tableView.reloadData()
    //        }
    

    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell")! as! VideoTableViewCell
        
        let video = self.videos[indexPath.row]
        
        cell.setCell(video)
        cell.setLength(video)
        
        return cell
    }
    
    
    //    Mark: - Model Delegate Method
    
//    func didUpdateVideo(_ videoManager: VideoManager, videos: [VideoModel]) {
//        
//        DispatchQueue.main.async {
//            videos.forEach { video in
//                let newVideoMenu = VideoMenu()
//                newVideoMenu.name = video.title
//                
//                newVideoMenu.videoId = video.videoId
//                newVideoMenu.thumbnail = video.thumbnail
//                
//                print(newVideoMenu)
//                
//                self.save(videoMenu: newVideoMenu)
//            }
//            
//        }
//    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func updateVideo(_ videoManager: VideoManager, video: VideoData) {
        
        DispatchQueue.main.async {
            let newVideoMenu = VideoMenu()
            newVideoMenu.name = video.items[0].snippet.title
            
            let tmpDuration = video.items[0].contentDetails.duration
            let durationString = self.videoTableViewCell.durationFormatter(tmpDuration)
            let durationIntArray = durationString.split(separator: ":").map { Int($0) }
            let durationInt = (durationIntArray[0] ?? 0) * 60 + (durationIntArray[1] ?? 0)
            newVideoMenu.durationString = durationString
            newVideoMenu.duration = durationInt
            
            newVideoMenu.videoId = video.items[0].id
            newVideoMenu.thumbnail = video.items[0].snippet.thumbnails.default.url
            
            print(newVideoMenu)
            
            self.save(videoMenu: newVideoMenu)
        }
    }
    
}
