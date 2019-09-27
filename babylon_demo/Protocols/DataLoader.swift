//
//  DataLoader.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct DataLoader {
    
    private let serviceProvider: ServiceProviding
    
    /// initialize DataLoader
    ///
    /// - Parameter serviceProvider: ServiceProviding
    init(withServiceProvider serviceProvider: ServiceProviding) {
        self.serviceProvider = serviceProvider
        
    }
}

extension DataLoader: DataLoading {

    /// This is helper method to retrieve data from server and save into core data
    ///
    /// - Parameters:
    ///   - savingDataHandler: data saving handler
    ///   - completionQueue: coomplitionQueue will be used within
    ///   - completion: coomplition block
    func loadData(withSavingDataHandler savingDataHandler: PersistentDataSaving, completionQueue: DispatchQueue, completion: @escaping (Error?) -> Void) {
        var userList = [UserResponse]()
        var postList = [PostResponse]()
        var commentList = [CommentResponse]()
        
        var receivedError: Error?
        let dispatchGroup = DispatchGroup()
        
        // retrieve user data
        dispatchGroup.enter()
        serviceProvider.service(ofType: .userService).retrieveData(usingParser: DataParser()) { (result: Result<[UserResponse], Error>) in
            defer {
                dispatchGroup.leave()
            }
            
            switch result {
            case .success(let list):
                userList = list
            case .failure(let error):
                receivedError = error
            }
            
        }
        
        // retrieve post data
        dispatchGroup.enter()
        serviceProvider.service(ofType: .postService).retrieveData(usingParser: DataParser()) { (result: Result<[PostResponse], Error>) in
            defer {
                dispatchGroup.leave()
            }
            
            switch result {
            case .success(let list):
                postList = list
            case .failure(let error):
                receivedError = error
            }
    
        }
        
        // retrieve comment data
        dispatchGroup.enter()
        serviceProvider.service(ofType: .commentService).retrieveData(usingParser: DataParser()) { (result: Result<[CommentResponse], Error>) in
            defer {
                dispatchGroup.leave()
            }
            
            switch result {
            case .success(let list):
                commentList = list
            case .failure(let error):
                receivedError = error
            }
            
        }
        
        
        // sync above services
        dispatchGroup.notify(queue: .global()) {
            if let _ = receivedError {
                completionQueue.async(execute: {
                    completion(receivedError)
                })
            } else {
                savingDataHandler.saveUsers(userList, posts: postList, comments: commentList, complition: { (error) in
                    if let _ = error {
                        completionQueue.async(execute: {
                            completion(error)
                        })
                    } else {
                        completionQueue.async(execute: {
                            completion(nil)
                        })
                    }
                })
            }
        }
    }
    
}
