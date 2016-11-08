//
//  Group+CoreDataProperties.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/7/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group");
    }

    @NSManaged public var name: String?
    @NSManaged public var hangouts: NSSet?
    @NSManaged public var members: NSSet?

}

// MARK: Generated accessors for hangouts
extension Group {

    @objc(addHangoutsObject:)
    @NSManaged public func addToHangouts(_ value: Hangout)

    @objc(removeHangoutsObject:)
    @NSManaged public func removeFromHangouts(_ value: Hangout)

    @objc(addHangouts:)
    @NSManaged public func addToHangouts(_ values: NSSet)

    @objc(removeHangouts:)
    @NSManaged public func removeFromHangouts(_ values: NSSet)

}

// MARK: Generated accessors for members
extension Group {

    @objc(addMembersObject:)
    @NSManaged public func addToMembers(_ value: User)

    @objc(removeMembersObject:)
    @NSManaged public func removeFromMembers(_ value: User)

    @objc(addMembers:)
    @NSManaged public func addToMembers(_ values: NSSet)

    @objc(removeMembers:)
    @NSManaged public func removeFromMembers(_ values: NSSet)

}
