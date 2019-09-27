//
//  DataRetriever.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct DataRetriever {
    
    private let urlComponents: URLComponents
    private let session: URLSession
    
    /// Initialization of DataRetriever
    ///
    /// - Parameters:
    ///   - session: URLSession (default .shared)
    ///   - urlComponents: URLComponents
    init(withSession session: URLSession = .shared, urlComponents: URLComponents) {
        self.session = session
        self.urlComponents = urlComponents
    }
}

extension DataRetriever: DataRetrieving {
    func retrieveData<T>(usingParser parser: DataParsing, result: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let url = urlComponents.url else {
            result(.failure(CustomError.network(errorDescription: "URL error")))
            return
        }
        
        session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            if let error = error {
                result(.failure(CustomError.network(errorDescription: error.localizedDescription)))
            }
            
            if let data = data {
                let parsedResult = parser.parse(fromData: data, inType: T.self)
                switch parsedResult {
                case .success(let objects):
                    result(.success(objects))
                case .failure(let error):
                    result(.failure(error))
                }
             }
            }.resume()
    }
}
