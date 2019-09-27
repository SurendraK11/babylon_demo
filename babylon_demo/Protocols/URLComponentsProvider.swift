//
//  URLComponentsProvider.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct URLComponentsProvider {
    
}

extension URLComponentsProvider: URLComponentsProviding {
    
    /// Responseible to provide URLComponents for given serviceType
    ///
    /// - Parameter serviceType: serviceType
    /// - Returns: URLComponents
    func urlComponents(forServiceType serviceType: ServiceType) -> URLComponents {
        switch serviceType {
        case .userService:
            return URLComponents(string: "http://jsonplaceholder.typicode.com/users")!
        case .postService:
            return URLComponents(string: "http://jsonplaceholder.typicode.com/posts")!
        case .commentService:
            return URLComponents(string: "http://jsonplaceholder.typicode.com/comments")!
            
        }
    }
    
}
