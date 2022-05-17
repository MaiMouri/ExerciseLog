//
//  VideoTableViewCell.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/12.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    
    var video: VideoModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setCell(_ v: VideoModel) {
        self.video = v
        
        // Check if there's a video
        guard self.video != nil else {
            return
        }
        
        //        Set the title
        self.titleLabel.text = video?.title
        
        
        
        //        Set the thumbnail
        guard self.video!.thumbnail != "" else {
            return
        }
        
        //        Download the thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        //        Get the shared URL Session object
        let session = URLSession.shared
        
        //        Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                //                Check the
                if url!.absoluteString != self.video!.thumbnail {
                    return
                }
                
                //                Create image
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }
        dataTask.resume()
    }
    
    func setLength(_ v: VideoModel){
        self.video = v
        
        guard self.video!.videoId != "" else {
            return
        }
        
        let videoId = self.video!.videoId
        let urlString = URL(string: "https://www.googleapis.com/youtube/v3/videos?id=\(videoId)&part=contentDetails&key=\(Constants.API_KEY)")
        let session = URLSession.shared
        let task = session.dataTask(with: urlString!) { (data, response, error) in
            if error != nil && data == nil { return }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(VideoData.self, from: data!)
                //                get duration
                let duration = decodedData.items[0].contentDetails.duration
                
                DispatchQueue.main.async {
                    self.lengthLabel.text = self.durationFormatter(duration)
                    self.video?.duration = self.durationFormatter(duration)
//                    print(self.video?.duration)
                }
                
            } catch {
                print("Error setting length decoding, \(error)")
            }
        }
        task.resume()
    }
    
    func durationFormatter(_ duration: String) -> String{
        let iso8601DurationPattern = "^PT(?:(\\d+)H)?(?:(\\d+)M)?(?:(\\d+)S)?$"
        let iso8601DurationRegex = try! NSRegularExpression(pattern: iso8601DurationPattern, options: [])
        
        if let match = iso8601DurationRegex.firstMatch(in: duration, options: [], range: NSRange(0..<duration.utf16.count)) {
            let hRange = match.range(at: 1)
            let hStr = (hRange.location != NSNotFound) ? (duration as NSString).substring(with: hRange) : ""
            let hInt = Int(hStr) ?? 0
            let mRange = match.range(at: 2)
            let mStr = (mRange.location != NSNotFound) ? (duration as NSString).substring(with: mRange) : ""
            let mInt = Int(mStr) ?? 0
            let sRange = match.range(at: 3)
            let sStr = (sRange.location != NSNotFound) ? (duration as NSString).substring(with: sRange) : ""
            let sInt = Int(sStr) ?? 0
            let durationFormatted =
            (hInt == 0)
            ? String(format: "%02d:%02d", mInt, sInt)
            : String(format: "%02d:%02d:%02d", hInt, mInt, sInt)
            
            return durationFormatted
        } else {
            print("bad format")
            return "NO"
        }
    }
}
