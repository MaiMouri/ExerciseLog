//
//  VideoViewController.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/11.
//

import UIKit

class VideoViewController: UIViewController {
    
    var videoManager = VideoManager()
    var videos = [VideoModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        videoManager.fetchVideoList()
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension VideoViewController: VideoManagerDelegate {
//    func didUpdateVideo(_ videoManager: VideoManager, video: VideoModel) {
//        DispatchQueue.main.async {
////            self.temperatureLabel.text = weather.temperatureString
////            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
////            self.cityLabel.text = weather.cityName
//        }
//    }
//    
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//}
