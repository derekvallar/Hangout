//
//  HangoutSearchController.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/29/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import UIKit

class HangoutSearchController: UISearchController {

    var hangoutSearchBar: HangoutSearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    init(searchResultsController: UIViewController!, searchBarFrame: CGRect, searchBarFont: UIFont, searchBarTextColor: UIColor, searchBarTintColor: UIColor) {
        super.init(searchResultsController: searchResultsController)

        searchBar.frame = searchBarFrame
        searchBar.placeholder = "Search for a Hangout"
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.backgroundColor = UIColor.white
        searchBar.barTintColor = UIColor.white

        var textField: UITextField? {
            if let field = searchBar.value(forKey: "searchField") as? UITextField {
                return field
            }
            return nil
        }

        if textField != nil {
            textField?.frame = searchBarFrame
            textField?.borderStyle = UITextBorderStyle.none
            textField?.textAlignment = NSTextAlignment.left
        }
        else {
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

}
