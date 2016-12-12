//
//  Hangout+CoreDataClass.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 11/7/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import Foundation
import CoreData

@objc(Hangout)
public class Hangout: NSManagedObject {

    func initData(_ group: Group, name: String, location: String, date: String, time: String, desc: String) {
        self.group = group
        self.name = name
        self.location = location
        self.date = date
        self.time = time
        self.desc = desc

        print("name: " + name + ".")
        print("location: " + location + ".")
        print("date: " + date + ".")
        print("time: " + time + ".")
        print("desc: " + desc + ".")

    }

}
