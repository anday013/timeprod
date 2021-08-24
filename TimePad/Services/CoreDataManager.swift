//
//  CoreDataManager.swift
//  TimePad
//
//  Created by Anday on 30.07.21.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "TasksContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core date: \(error)")
            }
        }        
        context = container.viewContext
    }
    
    func save() -> Bool {
        do {
            try context.save()
            return true
        } catch let error {
            print("Error saving Core Date: \(error.localizedDescription)")
            return false
        }
    }
    
    func delete(object: NSManagedObject) -> Bool {
        context.delete(object)
        return save()
    }
    
}
