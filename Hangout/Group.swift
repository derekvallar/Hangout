//
//  Group.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 10/20/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import Foundation

struct Group {
    var name: String?
    var members: [String]?

    init(name: String?, members: [String]?) {
        self.name = name
        self.members = members
    }
}
