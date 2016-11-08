//
//  User.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/1/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import CoreData

class UserMO: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var username: String?
}
