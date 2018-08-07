//
//  UerLocationViewController.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import UIKit
import CoreLocation

class UerLocationViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocation() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func compareLocation(_ notfication: NSNotification) {
        if let postion = notfication.userInfo!["location"] as? Position {
            if let latitude =  Double(postion.latitude!), let longitude = Double(postion.longitude!) {
                let coordinate: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
                if currentLocation.coordinate.latitude != 0, currentLocation.coordinate.longitude != 0 {
                    if currentLocation.distance(from: coordinate) < 11000 {
                        self.messageLabel.text = "if the ISS is above"
                    }
                }
                
            }
        }
    }
    
    func setupLocation() {
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
}

extension UerLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentLocation = manager.location
        NotificationCenter.default.addObserver(self, selector: #selector(compareLocation(_:)), name: NSNotification.Name("notifyUser"), object: nil)
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
