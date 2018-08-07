//
//  Position.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import Foundation

struct  Position: Codable {
    var latitude: String?
    var longitude: String?
}


struct ISSPostion: Codable {
    var message: String?
    var position: Position?
    //var timestamp: Int
    
    private enum CodingKeys: String, CodingKey {
        case message
        case position = "iss_position"
        //case timestamp
    }
}
