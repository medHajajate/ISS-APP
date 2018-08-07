//
//  PassengerPresenter.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import Foundation

protocol PassengerPresenterInput: class {
    func loadData()
    func numberOfItems() -> Int
    func passanger(at row: Int) -> People
}

class PassengerPresenter {
    
    
    var view: PassengersViewControllerInput?
    
    private var peoples: [People] = []
    
    init(delegate: PassengersViewControllerInput) {
        self.view = delegate
    }

}

extension PassengerPresenter: PassengerPresenterInput {
    
    func loadData() {
        APIManager.sharedInstance.getPassengers(onSuccess: { passenger in
            print("\(passenger.people?.count)")
            self.peoples = passenger.people!
            self.view?.reloadData()
        }, onFailure: { error in
            self.view?.showError(error)
        })
    }
    
    func numberOfItems() -> Int {
        return peoples.count
    }
    
    func passanger(at row: Int) -> People {
        return peoples[row]
    }
}
