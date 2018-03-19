//
//  CoreDataManager.swift
//  CoreDataApp
//
//  Created by Mohammad reza Koohkan on 12/25/1396 AP.
//  Copyright © 1396 AP Mohammad reza Koohkan. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    private class func getContex() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     return appDelegate.persistentContainer.viewContext
    }
   class func saveObjects(name: String, id: Int,phoneNumber: Int,Picture:String) -> Bool {
    
    //Saving Objects
    
    let context = getContex()
    
    //entity tarif shode too coredata "User"
    
    let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
    let manageObject = NSManagedObject(entity: entity!, insertInto: context)
    
    //meghdar dehi
    
     manageObject.setValue(name, forKey: "name")
    manageObject.setValue(id, forKey: "id")
    manageObject.setValue(phoneNumber, forKey: "phoneNumber")
    manageObject.setValue(Picture, forKey: "picture")
    do {
        try context.save()
        return true
    }catch{
        return false
    }
    }
    class func fetchObject() -> [User]? {
    let context = getContex()
        var user : [User]? = nil
        do {
            user = try context.fetch(User.fetchRequest())
            return user
        }catch{
            return user
        }
    }
    
    //Deleting Objects
    class func deleteObject(user: User) -> Bool {
        let context = getContex()
        context.delete(user)
        do {
            try context.save()
            return true
        }catch{
            return false
        }
    }
    
    
    
}

