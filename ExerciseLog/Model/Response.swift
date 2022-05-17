//
//  Response.swift
//  ExerciseLog
//
//  Created by Mai Mouri on 2022/05/12.
//

import Foundation

struct Response: Decodable {
    
    var items: [VideoModel]?
    
    enum CodingKeys:String, CodingKey {
        
        case items
    }
    
    init (from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = try container.decode([VideoModel].self, forKey: .items)
    }
}
