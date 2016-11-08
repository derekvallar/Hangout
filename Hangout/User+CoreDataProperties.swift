//
//  User+CoreDataProperties.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/8/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var username: String?
    @NSManaged public var name: String?
    @NSManaged public var groups: NSSet?

}

// MARK: Generated accessors for groups
extension User {

    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: Group)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: Group)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSSet)

}
