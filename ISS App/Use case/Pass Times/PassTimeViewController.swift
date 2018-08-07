//
//  PassTimeViewController.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import UIKit

class PassTimeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var passTime: [PassTime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GPSLoaction().getGPSLocation(completion: { passTime in
            self.passTime = passTime
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension PassTimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerCell", for: indexPath) as! PassengerCell
        let duration = passTime[indexPath.row].duration
        cell.configure(name: "\(duration)")
        return cell
    }
}
