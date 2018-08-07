//
//  UserLocation.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import Foundation
import CoreLocation

class GPSLoaction {
    
    func getGPSLocation(completion: (_ passTime: [PassTime]) -> Void) {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            
            currentLocation = locManager.location
            
            let latitude = String(format: "%.7f", currentLocation.coordinate.latitude)
            let longitude = String(format: "%.7f", currentLocation.coordinate.longitude)
            
            debugPrint("Latitude:", latitude)
            debugPrint("Longitude:", longitude)
            
           let pass = APIManager.sharedInstance.getPassTime(lat: latitude, long: longitude)
            completion(pass)  // your block of code you passed to this function will run in this way
            
        }
        
    }
}
