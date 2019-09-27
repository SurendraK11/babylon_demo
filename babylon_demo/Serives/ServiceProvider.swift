//
//  ServiceProvider.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct ServiceProvider {
    let urlComponentProvider: URLComponentsProviding
    init(withURLComponentProvider urlComponentProvider: URLComponentsProviding) {
        self.urlComponentProvider = urlComponentProvider
    }
}

extension ServiceProvider: ServiceProviding {
    func service(ofType type: ServiceType) -> DataRetrieving {
        return DataRetriever(urlComponents: self.urlComponentProvider.urlComponents(forServiceType: type))
        
    }
}


