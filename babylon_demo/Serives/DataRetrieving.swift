//
//  DataRetrieving.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// DataRetrieving is responsible for server interaction and provide data in expected type
protocol DataRetrieving {
    /// responsible for server interaction and provide data in expected type
    ///
    /// - Parameters:
    ///   - parser: DataParsing (parse server data)
    ///   - result:  Result : Success(expected type) or  Result : failure(Error)
    func retrieveData<T: Decodable>(usingParser parser: DataParsing, result: @escaping (Result<T, Error>) -> Void)
    
}
