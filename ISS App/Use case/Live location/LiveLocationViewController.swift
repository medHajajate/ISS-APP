//
//  LiveLocationViewController.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import UIKit
import MapKit

class LiveLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var annotation = MKPointAnnotation()
    
    var timer = Timer()
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)

    override func viewDidLoad() {
        super.viewDidLoad()
        getISSLoaction()
    }
    
    func AddAnnotation(position: Position) {
        let location = GPSLoaction().convertToLocation(position.latitude!, position.longitude!)
        if mapView.annotations.isEmpty {
            DispatchQueue.main.async {
                self.annotation.coordinate = location
                self.mapView.camera.centerCoordinate = location
                self.mapView.addAnnotation(self.annotation)
            }
            
        } else {
            self.annotation.coordinate = location
            UIView.animate(withDuration: 0.2, animations: {
                self.mapView.camera.centerCoordinate = location
            })
           
        }
        
    }
    
    @objc func getISSPostion() {
        
        APIManager.sharedInstance.getISSPosition(onSuccess: { issPosition in
            print("\(issPosition)")
            if let position = issPosition.position {
                self.AddAnnotation(position: position)
                self.notify(position: position)
            }
        },onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
        
    }
    
    func getISSLoaction(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getISSPostion), userInfo: nil, repeats: true)
    }
    
    func notify(position: Position) {
        NotificationCenter.default.post(name: Notification.Name("notifyUser"), object: nil, userInfo: ["location": position])
    }
    
    

}


extension LiveLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "ISS_pin"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = #imageLiteral(resourceName: "iss")
            
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
