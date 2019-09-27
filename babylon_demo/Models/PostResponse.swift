//
//  PostResponse.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// This is used to parse post JSON response received from server
struct PostResponse: Decodable {
    let id: Int
    let body: String
    let title: String
    let userId: Int
    
}
