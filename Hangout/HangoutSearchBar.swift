//
//  HangoutSearchBar.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/29/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import UIKit

class HangoutSearchBar: UISearchBar {

    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    var textField: UITextField? {
        if let field = self.value(forKey: "searchField") as? UITextField {
            return field
        }
        return nil
    }

    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        super.init(frame: frame)

        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor

        searchBarStyle = UISearchBarStyle.prominent
        isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        if (textField != nil) {
            textField?.frame = CGRect.init(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
            textField?.borderStyle = UITextBorderStyle.none

            textField?.font = preferredFont
            textField?.textColor = preferredTextColor
            textField?.backgroundColor = barTintColor
        }

        super.draw(rect)
    }
}
