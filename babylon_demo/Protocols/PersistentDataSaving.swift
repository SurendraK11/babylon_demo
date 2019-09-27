//
//  PersistentDataSaving.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// Responsible to save data persistently
protocol PersistentDataSaving {
    
    /// Saving data
    ///
    /// - Parameters:
    ///   - users: [UserResponse]
    ///   - posts: [PostResponse]
    ///   - comments: [CommentResponse]
    ///   - complition: Complition block (Error?) -> Void), error will be nil if there is no issue while saving data
    func saveUsers(_ users: [UserResponse], posts: [PostResponse], comments: [CommentResponse], complition: (Error?) -> Void)
}
