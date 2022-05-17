//
//  VideoManager.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/11.
//

import Foundation
import UIKit

protocol VideoManagerDelegate {
    func videosFetched(_ videos:[VideoModel])
    func didUpdateVideo(_ videoManager: VideoManager, videos: [VideoModel])
    func didFailWithError(error: Error)
}


struct VideoManager {
    
    var delegate: VideoManagerDelegate?
    var videoArray: [VideoModel] = [VideoModel]()
    
    let videoURL = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
    
    func fetchVideoList() {
        let urlString = "\(videoURL)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //  1.Create a URL
        if let url = URL(string: urlString) {
            // 2. Create a Session
            let session = URLSession(configuration: .default)
            //  3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil || data == nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }

                do {
                    
                    // Parsing the data into video objects
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let response = try decoder.decode(Response.self, from: data!)
                    
                    if response.items != nil {
                        DispatchQueue.main.async {
                            // Call the "videosFetched" method of the delegate
                            self.delegate?.videosFetched(response.items!)
//                            print(response.items)
                        
                            self.delegate?.didUpdateVideo(self, videos: response.items!)
                        }
                    }
                    
                    // dump(response)
                }
                catch {
//                    print(error)
                }
            }
            //            4. Start the task
            task.resume()
        }
    }
    

 
    
}

