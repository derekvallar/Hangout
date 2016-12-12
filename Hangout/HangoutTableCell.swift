//
//  HangoutTableCell.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/9/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import UIKit

class HangoutTableCell: UITableViewCell {

    @IBOutlet weak var title: UITextView!
    @IBOutlet weak var time: UITextView!
    @IBOutlet weak var location: UITextView!
    @IBOutlet weak var cardView: UIView!

    var hangout: Hangout! {
        didSet {
            title.text = hangout.name ?? ""

            var tempTime = [String]()
            if (hangout.date != nil && hangout.date != "") {
                tempTime.append(hangout.date!)
            }
            if (hangout.time != nil && hangout.time != "") {
                tempTime.append(hangout.time!)
            }

            time.text = tempTime.count > 1 ? tempTime.joined(separator: ", ") : tempTime.first

            location.text = hangout.location ?? ""

            title.textContainerInset = UIEdgeInsets.zero
            time.textContainerInset = UIEdgeInsets.zero
            location.textContainerInset = UIEdgeInsets.zero

            cardView.layer.cornerRadius = 2
            cardView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
            cardView.layer.shadowRadius = 4
            cardView.layer.shadowOpacity = 0.25
        }
    }
}
