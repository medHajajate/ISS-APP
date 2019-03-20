//
//  APIManager.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    
    let baseURL = "http://api.open-notify.org/iss-now.json"
    let passengerUrl = "http://api.open-notify.org/astros.json"
    let passTimeURL = "http://api.open-notify.org/iss-pass.json?"//lat=LAT&lon=LON
        
    static let sharedInstance = APIManager()
    
    func getISSPosition(onSuccess: @escaping(ISSPostion) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL
        var request: URLRequest = URLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ISSPostion.self, from: data)
                onSuccess(response)
                
            } catch let err {
                onFailure(err)
            }
        })
        task.resume()
    }
    
    
    func getPassTime(lat: String, long: String, onSuccess: @escaping([PassTime]) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = passTimeURL + "lat=\(lat)" + "&" + "lon=\(long)&n=10"
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CALLBACK.self, from: data)
                let passTime = response.response 
                onSuccess(passTime)
                
            } catch let err {
                print(err.localizedDescription)
                onFailure(err)
            }
        })
        task.resume()
    }
    
    func getPassengers(onSuccess: @escaping(PassengersList) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = passengerUrl
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(PassengersList.self, from: data)
                onSuccess(response)
                
            } catch let err {
                onFailure(err)
            }
        })
        task.resume()
    }
}
