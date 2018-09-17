//
//  PassengersViewController.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import UIKit

protocol PassengersViewControllerInput: class {
    func reloadData()
    func showError(_ error: Error)
}

class PassengersViewController: UIViewController {

    fileprivate lazy var presenter: PassengerPresenterInput = {
        return PassengerPresenter(delegate: self)
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 84
        tableView.tableFooterView = UIView()
        activityIndicatorView.startAnimating()
        presenter.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PassengersViewController: PassengersViewControllerInput {
    func reloadData() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
            self.tableView.reloadData()
        }
        
    }
    
    func showError(_ error: Error) {
        activityIndicatorView.stopAnimating()
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.show(alert, sender: nil)
    }
}

extension PassengersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerCell", for: indexPath) as! PassengerCell
        cell.configure(people: presenter.passanger(at: indexPath.row))
        return cell
    }
}

extension PassengersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
