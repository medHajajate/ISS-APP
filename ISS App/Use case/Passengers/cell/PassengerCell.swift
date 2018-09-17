//
//  PassengerCell.swift
//  ISS App
//
//  Created by red on 8/7/18.
//  Copyright © 2018 hajajate. All rights reserved.
//

import UIKit

class PassengerCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(people: People) {
        nameLabel.text = people.name
    }
    
    func configure(passTime: PassTime) {
        nameLabel.text = passTime.time//String(time)
    }

}
