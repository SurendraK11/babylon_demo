//
//  CommentResponse.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// This is used to parse comment JSON response received from server
struct CommentResponse: Decodable {
    let id: Int
    let body: String
    let email: String
    let name: String
    let postId: Int
    
}
