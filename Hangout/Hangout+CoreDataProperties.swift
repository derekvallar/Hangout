//
//  Hangout+CoreDataProperties.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/9/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import Foundation
import CoreData

extension Hangout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hangout> {
        return NSFetchRequest<Hangout>(entityName: "Hangout");
    }

    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var time: String?
    @NSManaged public var address: String?
    @NSManaged public var group: Group?

}
