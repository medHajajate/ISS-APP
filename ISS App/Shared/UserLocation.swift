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
    
    func getPassTime(completion: @escaping (_ passTime: [PassTime]) -> Void, onFailure: @escaping (_ error: Error) -> Void) {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.startUpdatingLocation()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            
            guard let currentLocation = locManager.location else {
                onFailure(NSError(domain: "", code: 123456, userInfo: [NSLocalizedDescriptionKey : "error location"]))
                return }
            
            let latitude = String(format: "%.7f", currentLocation.coordinate.latitude)
            let longitude = String(format: "%.7f", currentLocation.coordinate.longitude)
            
            debugPrint("Latitude:", latitude)
            debugPrint("Longitude:", longitude)
            
            APIManager.sharedInstance.getPassTime(lat: latitude, long: longitude, onSuccess: { pass in
                completion(pass)
            }, onFailure: { error in
                onFailure(error)
            })
            
            
        }
        
    }
    
    func getGPSLocation(completion: (_ position: Position) -> Void) {
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
            
            //let pass = APIManager.sharedInstance.getPassTime(lat: latitude, long: longitude)
            completion(Position(latitude: latitude, longitude: longitude))
            
        }
        
    }
    
    func convertToLocation(_ latitude: String, _ longitude: String) -> CLLocationCoordinate2D{
        let lat = Double(latitude)
        let lon = Double(longitude)
        
        return CLLocationCoordinate2D(latitude:lat!, longitude:lon!)
        
    }
}


