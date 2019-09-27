//
//  URLComponentsProviderTests.swift
//  babylon_demoTests
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import XCTest
@testable import babylon_demo

class URLComponentsProviderTests: XCTestCase {

    let urlComponentsProvider: URLComponentsProviding = URLComponentsProvider()
    
    func testURLStringForUserService() {
        let urlComponent = urlComponentsProvider.urlComponents(forServiceType: .userService)
        XCTAssertEqual(urlComponent.url?.absoluteString, "http://jsonplaceholder.typicode.com/users", "url must be http://jsonplaceholder.typicode.com/users")
    }
    
    func testURLStringForPostService() {
        let urlComponent = urlComponentsProvider.urlComponents(forServiceType: .postService)
        XCTAssertEqual(urlComponent.url?.absoluteString, "http://jsonplaceholder.typicode.com/posts", "url must be http://jsonplaceholder.typicode.com/posts")
    }
    
    func testURLStringForCommentService() {
        let urlComponent = urlComponentsProvider.urlComponents(forServiceType: .commentService)
        XCTAssertEqual(urlComponent.url?.absoluteString, "http://jsonplaceholder.typicode.com/comments", "url must be http://jsonplaceholder.typicode.com/comments")
    }

}
