//
//  HangoutGroupCell.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 10/20/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import UIKit

class HangoutGroupCell: UITableViewCell {

    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var group: Group! {
        didSet {
            groupLabel.text = group.name ?? group.members?.joined(separator: ", ")
        }
    }

}
