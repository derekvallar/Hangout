//
//  HangoutGroupCell.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 10/20/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import UIKit

class GroupTableCell: UITableViewCell {

    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var group: Group! {
        didSet {
            if (group.name != nil) {
                groupLabel.text = group.name
            }
            else {
                var members = [String]()
                for user in group.members!.allObjects as! [User] {
                    members.append(user.name!)
                }
                groupLabel.text = members.joined(separator: ", ")
            }
        }
    }
}
