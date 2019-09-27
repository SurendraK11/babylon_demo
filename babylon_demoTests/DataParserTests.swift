//
//  DataParserTests.swift
//  babylon_demoTests
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import XCTest
@testable import babylon_demo

class DataParserTests: XCTestCase {

    let dataParser: DataParsing = DataParser()
    
    func testUserResponseParsing() {
        self.testReturnedType(forFile: "Users", ofType: "json", expectedReturnedType: [UserResponse].self)
        
    }
    
    func testPostResponseParsing() {
        self.testReturnedType(forFile: "Posts", ofType: "json", expectedReturnedType: [PostResponse].self)
        
    }
    
    func testCommentResponseParsing() {
        self.testReturnedType(forFile: "Comments", ofType: "json", expectedReturnedType: [CommentResponse].self)
        
    }
    
    
    // MARK: - Private methods
    private func testReturnedType<T: Decodable>(forFile fileName: String, ofType fileType: String, expectedReturnedType returnedType: T.Type) {
        if let data = TestHelper.data(ofFile: fileName, ofType: fileType) {
            typealias expectedType = T
            let result = dataParser.parse(fromData: data, inType: expectedType.self)
            
            var returnedType: expectedType?
            var parseError: Error?
            switch result {
            case .success(let types):
                returnedType = types
            case .failure(let error):
                parseError = error
            }
            
            XCTAssertNotNil(returnedType, "Parsing should return array of \(expectedType.self)")
            XCTAssertNil(parseError, "parsing erorr must be nil")
        }
    }
}
