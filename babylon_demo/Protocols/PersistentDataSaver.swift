//
//  SaveDataControler.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import CoreData

struct PersistentDataSaver {
    
}

extension PersistentDataSaver:  PersistentDataSaving {
    /// Responsible to save data persistently (CoreData)
    ///
    /// - Parameters:
    ///   - users: [UserResponse]
    ///   - posts: [PostResponse]
    ///   - comments: [CommentResponse]
    ///   - complition: Complition block (Error?) -> Void), error will be nil if there is no issue while saving data
    func saveUsers(_ users: [UserResponse], posts: [PostResponse], comments: [CommentResponse], complition: (Error?) -> Void) {
        let backgroundManagedObjectContext = CoreDataManager.shared.persistentContainer.newBackgroundContext()
        for user in users {
            let userEntity = self.userEntity(for: user, using: backgroundManagedObjectContext)
            let filteredPosts = posts.filter({ $0.userId == user.id })
            for post in filteredPosts {
                
                let postEntity = self.postEntity(for: post, using: backgroundManagedObjectContext)
                userEntity.addToPosts(postEntity)
                let filteredComments = comments.filter({ $0.postId == post.id })
                
                for comment in filteredComments {
                    
                    let commentEntity = self.commentEntity(for: comment, using: backgroundManagedObjectContext)
                    postEntity.addToComments(commentEntity)
                }
            }
        }
        
        backgroundManagedObjectContext.performAndWait {
            if backgroundManagedObjectContext.hasChanges {
                do {
                    try backgroundManagedObjectContext.save()
                    complition(nil)
                } catch {
                    complition(CustomError.saveData(errorDescription: "Issue found to save data"))
                }
            }
        }
    }
    
    
    // MARK: - Private methods
    
    /// Helper method to transform response into User entity
    ///
    /// - Parameters:
    ///   - user: UserResponse
    ///   - backgroundManagedObjectContext: NSManagedObjectContext
    /// - Returns: User entity
    private func userEntity(for user: UserResponse, using backgroundManagedObjectContext: NSManagedObjectContext) -> User {
        let userEntity = User(entity: User.entity(), insertInto: backgroundManagedObjectContext)
        userEntity.id = Int16(user.id)
        userEntity.email = user.email
        userEntity.name = user.name
        userEntity.phone = user.phone
        userEntity.username = user.username
        userEntity.website = user.website
        
        return userEntity
    }
    
    /// Helper method to transform response into Post entity
    ///
    /// - Parameters:
    ///   - post: PostResponse
    ///   - backgroundManagedObjectContext: NSManagedObjectContext
    /// - Returns: Post entity
    private func postEntity(for post: PostResponse, using backgroundManagedObjectContext: NSManagedObjectContext) -> Post {
        let postEntity = Post(entity: Post.entity(), insertInto: backgroundManagedObjectContext)
        postEntity.body = post.body
        postEntity.id = Int16(post.id)
        postEntity.title = post.title
        postEntity.userId = Int16(post.userId)
        
        return postEntity
    }
    
    /// Helper method to transform response into Comment entity
    ///
    /// - Parameters:
    ///   - comment: CommentResponse
    ///   - backgroundManagedObjectContext: NSManagedObjectContext
    /// - Returns: Comment entity
    private func commentEntity(for comment: CommentResponse, using backgroundManagedObjectContext: NSManagedObjectContext) -> Comment {
        let commentEntity = Comment(entity: Comment.entity(), insertInto: backgroundManagedObjectContext)
        commentEntity.body = comment.body
        commentEntity.email = comment.email
        commentEntity.id = Int16(comment.id)
        commentEntity.name = comment.name
        commentEntity.postId = Int16(comment.postId)
        
        return commentEntity
    }
    
}
