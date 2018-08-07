//
//  PassTime.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import Foundation


struct PassTime: Codable {
    var duration: Int?
    var risetime: Int?
}

struct CALLBACK: Codable {
    var response: [PassTime]
}
