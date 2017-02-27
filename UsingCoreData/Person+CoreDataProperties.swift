//
//  Person+CoreDataProperties.swift
//  UsingCoreData
//
//  Created by Appinventiv on 27/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: Int64
    @NSManaged public var age: Int64

}
