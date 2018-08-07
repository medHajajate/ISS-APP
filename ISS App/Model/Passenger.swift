//
//  Passenger.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import Foundation


struct  People: Codable {
    var craft: String?
    var name: String?
}


struct PassengersList: Codable {
    var message: String?
    var people: [People]?
    var number: Int?
    
}
