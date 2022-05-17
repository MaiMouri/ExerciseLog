//
//  VideoTableViewController.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/11.
//

import UIKit

class VideoTableViewController: UITableViewController, VideoManagerDelegate {
    func videosFetched(_ videos: [VideoModel]) {
        self.videos = videos
        print("fetched")
        tableView.reloadData()
    }
    
    
    var videos = [VideoModel]()
    var videoManager = VideoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoManager.delegate = self
        videoManager.fetchVideoList()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell")! as! VideoTableViewCell
        
        let video = self.videos[indexPath.row]
        
        cell.setCell(video)
        cell.setLength(video)
//        cell.textLabel?.text = videos[indexPath.row].title
        
        return cell
    }
    
    //    Mark: - Model Delegate Method
    
    
    func didUpdateVideo(_ videoManager: VideoManager, videos: [VideoModel]) {

        DispatchQueue.main.async {
            //            self.temperatureLabel.text = weather.temperatureString
            //            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            //            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    //    api
    //https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLk2hgOOTvKIiKnNxXZD-NUwhu-kYr1FFR&key=AIzaSyBriCj7fahdJM88iibQS2Q8FSdPab0Sef0
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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