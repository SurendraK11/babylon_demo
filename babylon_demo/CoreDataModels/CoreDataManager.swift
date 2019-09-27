//
//  CoreDataManager.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer : NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "babylon_demo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            debugPrint("storeDescription : \(storeDescription) ")
            if let error = error as NSError? {
                fatalError("unresolved error : \(error), \(error.userInfo)")
            }
        })
        return container
    
    }()
    
    
    func saveContext(with complition: (Error?) -> ()) {
        let context = persistentContainer.viewContext
        guard context.hasChanges else {
            return
        }
        if context.hasChanges {
            do {
                try context.save()
                complition(nil)
            } catch {
                complition(error as NSError)
            }
        }
    }
    
}
