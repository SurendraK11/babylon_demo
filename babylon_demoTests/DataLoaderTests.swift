//
//  DataLoaderTests.swift
//  babylon_demoTests
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import XCTest
import CoreData
@testable import babylon_demo

class DataLoaderTests: XCTestCase {
    
    let dataLoader: DataLoading = DataLoader(withServiceProvider: ServiceProvider(withURLComponentProvider: URLComponentsProvider()))
    
    override func setUp() {
         deleteData(forEntityName: "User")
    }

    func testCascadeDeleteOperation() {
        let expectation = XCTestExpectation(description: "Download data")
        dataLoader.loadData(withSavingDataHandler: PersistentDataSaver(), completionQueue: DispatchQueue.main) {[weak self] (error) in
            XCTAssertNil(error, "There should not be any error \(error!)")
            //delete only User entity
            self?.deleteData(forEntityName: "User")
            let context = CoreDataManager.shared.persistentContainer.viewContext
            var fetchRequest: NSFetchRequest<NSFetchRequestResult>
            for entity in ["User", "Post", "Comment"] {
                fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
                do {
                    let result = try context.fetch(fetchRequest)
                    XCTAssertEqual(result.count, 0, "There must not be any data for \(entity)")
                } catch let error as NSError {
                    print("Error on fetching User: \(error) \(error.userInfo)")
                    XCTAssertNotNil(error, "found error: \(error) ")
                    
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDataLoaderLoadData() {
        let expectation = XCTestExpectation(description: "Download data")
        dataLoader.loadData(withSavingDataHandler: PersistentDataSaver(), completionQueue: DispatchQueue.main) { (error) in
            XCTAssertNil(error, "There should not be any error \(error!)")
            let context = CoreDataManager.shared.persistentContainer.viewContext
            var fetchRequest: NSFetchRequest<NSFetchRequestResult>
            for entity in ["User", "Post", "Comment"] {
                fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
                do {
                    let result = try context.fetch(fetchRequest)
                    XCTAssertGreaterThan(result.count, 0, "There must be \(entity) data")
                } catch let error as NSError {
                    print("Error on fetching User: \(error) \(error.userInfo)")
                    XCTAssertNotNil(error, "found error: \(error) ")
                }
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    private func deleteData(forEntityName entityName: String) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                context.delete(managedObject as! NSManagedObject)
            }
            CoreDataManager.shared.saveContext { (error) in
                if let _ = error {
                    XCTAssertNil(error, "Save context issue \(error!) \(error!.localizedDescription)")
                }
            }
            
        } catch let error as NSError {
            print("Deletion error : \(error) \(error.userInfo)")
            XCTAssertNotNil(error, "found error: \(error) ")
        }
    }
}
