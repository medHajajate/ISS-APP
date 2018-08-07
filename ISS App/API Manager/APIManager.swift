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
    static let sharedInstance = APIManager()
    
    func getISSPosition(onSuccess: @escaping(ISSPostion) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
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
    
}
