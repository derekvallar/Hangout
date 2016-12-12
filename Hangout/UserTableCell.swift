//
//  UserTableCell.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/1/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!

    var user: User! {
        didSet {
            userLabel.text = user.firstname! + " " + user.lastname!
            usernameLabel.text = user.username
        }
    }
}
