//
//  User+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Mohammad reza Koohkan on 12/27/1396 AP.
//  Copyright © 1396 AP Mohammad reza Koohkan. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var flag: Bool

}
