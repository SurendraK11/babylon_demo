//
//  UserResponse.swift
//  babylon_demo
//
//  Created by Surendra
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// This is used to parse user JSON response received from server
struct UserResponse : Decodable {
    let id: Int
    let email: String
    let name: String
    let phone: String
    let username: String
    let website: String
    
}
