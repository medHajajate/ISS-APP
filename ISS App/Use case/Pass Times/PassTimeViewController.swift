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
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var passTime: [PassTime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        activityIndicatorView.startAnimating()
        loadPassTimes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPassTimes() {
        GPSLoaction().getPassTime(completion: { passTime in
            self.passTime = passTime
            //DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
                self.tableView.reloadData()
            //}
        }, onFailure: { error in
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
    }
    

}

extension PassTimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerCell", for: indexPath) as! PassengerCell
        cell.configure(passTime: passTime[indexPath.row])
        return cell
    }
}


extension PassTimeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
