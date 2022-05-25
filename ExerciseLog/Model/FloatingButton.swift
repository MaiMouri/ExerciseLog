//
//  FloatingButton.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/15.
//

import Foundation
import UIKit

class FloatingButton:UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemPink
        self.layer.borderColor = UIColor.black.cgColor
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        self.setImage(image, for: .normal)
        
        // Shadow
        self.tintColor = .white
        self.setTitleColor(.white, for: .normal)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.3
        //
        //Corner Radius
        self.layer.cornerRadius = 30
    }
    
}
