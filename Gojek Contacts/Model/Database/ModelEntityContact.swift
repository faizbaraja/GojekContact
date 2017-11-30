//
//  ModelEntityContact.swift
//  Gojek Contacts
//
//  Created by Faiz Umar Baraja on 28/11/2017.
//  Copyright © 2017 FaizBarajaApps. All rights reserved.
//

import UIKit
import CoreData

class ModelEntityContact: NSObject {
    func saveContactData(dictContactData: [String:Any]) {
        var contactObject: [NSManagedObject] = []
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedContext)!
        
        let contactEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
        contactEntity.setValue(dictContactData["first_name"], forKeyPath: "first_name")
        contactEntity.setValue(dictContactData["last_name"], forKeyPath: "last_name")
        contactEntity.setValue(dictContactData["id"], forKeyPath: "id")
        contactEntity.setValue(dictContactData["favorite"], forKeyPath: "favorite")
        contactEntity.setValue(dictContactData["profile_pic"], forKeyPath: "profile_pic")
        
        // 4
        do {
            try managedContext.save()
            contactObject.append(contactEntity)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllContactRecords() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func getAllContactData() -> [NSManagedObject]{
        var contactObject: [NSManagedObject] = []
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return contactObject
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Contact")
        
        //3
        do {
            contactObject = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return contactObject
        }
        return contactObject
    }
}
