//
//  CoreDataManager.swift
//  TimePad
//
//  Created by Anday on 30.07.21.
//

import Foundation
import CoreData

class CoreDateManager {
    static let instance = CoreDateManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "TasksContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core date: \(error)")
            }
        }
        
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving Core Date: \(error.localizedDescription)")
        }
    }
    
    
}
