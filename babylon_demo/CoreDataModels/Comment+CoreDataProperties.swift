//
//  Comment+CoreDataProperties.swift
//  
//
//  Created by Surendra.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var body: String
    @NSManaged public var email: String
    @NSManaged public var id: Int16
    @NSManaged public var name: String
    @NSManaged public var postId: Int16
    @NSManaged public var postedNote: Post

}
