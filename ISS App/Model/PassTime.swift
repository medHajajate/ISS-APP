//
//  PassTime.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import Foundation


struct PassTime: Codable {
    var duration: Double?
    var risetime: Double?
    
    var time: String {
        let date = Date(timeIntervalSince1970: risetime!)
        return date.debugDescription
    }
}

struct CALLBACK: Codable {
    var response: [PassTime]
}
