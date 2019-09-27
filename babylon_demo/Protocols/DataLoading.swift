//
//  DataLoading.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// Responsible to data
protocol DataLoading {
    
    /// This is helper method to retrieve and save data
    ///
    /// - Parameters:
    ///   - savingDataHandler: helper class to save data
    ///   - completionQueue: completionQueue
    ///   - completion: Complition block (Error?) -> Void), error will be nil if there is no issue while loading and saving data
    func loadData(withSavingDataHandler savingDataHandler:  PersistentDataSaving, completionQueue: DispatchQueue, completion: @escaping (Error?) -> Void)

}
