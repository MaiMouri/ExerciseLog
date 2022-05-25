//
//  ThumbnailCell.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/20.
//

import UIKit

class ThumbnailCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    
    var video: VideoMenu?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func setVideoCell(_ v: VideoMenu) {
        self.video = v
        guard self.video != nil else {
            return
        }

        self.titleLabel.text = video?.name
        self.durationLabel.text = video?.durationString

        guard self.video!.thumbnail != "" else {
            return
        }
        
        let url = URL(string: self.video!.thumbnail)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.thumbnailView.image = image
                }
            }
        }
        dataTask.resume()
    }
    
}
