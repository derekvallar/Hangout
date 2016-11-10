//
//  Group+CoreDataClass.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/7/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import Foundation
import CoreData

@objc(Group)
public class Group: NSManagedObject {

    func initData(_ members: [User]) {
        addToMembers(NSSet.init(array: members))
        updateDefaultName()
        uniqueID = UUID().uuidString
    }

    func updateDefaultName() {
        if (members?.count == 1) {
            let user = members?.anyObject() as! User
            name = (user.firstname)! + " " + (user.lastname)!
        }
        else {
            let maxCharacters = 40
            var currCharacters = 0
            var nameList = [String]()

            let userSet = members?.allObjects as! [User]
            for user in userSet {
                let name = user.firstname!
                nameList.append(name)
                currCharacters += name.characters.count

                if (currCharacters > maxCharacters) {
                    break
                }
            }

            name = nameList.joined(separator: ", ")
            if (currCharacters > maxCharacters) {
                let index = name?.index((name?.startIndex)!, offsetBy: maxCharacters)
                name = name?.substring(to: index!)
                name?.append("...")
            }

        }
    }

    @nonobjc public class func fetchRequest(_ uuid: String?) -> NSFetchRequest<Group> {
        let request = NSFetchRequest<Group>(entityName: "Group")
        request.predicate = NSPredicate(format: "uniqueID == %@", uuid!)
        return request
    }
}
