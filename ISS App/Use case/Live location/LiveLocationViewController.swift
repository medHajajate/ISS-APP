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

    
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getISSPostion()
    }
    
    func ShowPostionISS(latitude: String, longitude: String) {
        let lat = Double(latitude)
        let lon = Double(longitude)
        
        let location = CLLocationCoordinate2D(latitude:lat!, longitude:lon!)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Big Ben"
        annotation.subtitle = "London"
        mapView.addAnnotation(annotation)
    }
    
    func getISSPostion() {
        
        APIManager.sharedInstance.getISSPosition(onSuccess: { issPosition in
            print("\(issPosition)")
            self.ShowPostionISS(latitude: (issPosition.position?.latitude)!, longitude: (issPosition.position?.longitude)!)
        },onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
        
    }
    
    

}
