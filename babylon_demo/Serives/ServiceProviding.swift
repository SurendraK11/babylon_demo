//
//  ServiceProviding.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// This acts as factory to provide service
protocol ServiceProviding {
    
    /// This is responsible to return DataRetrieving service for give service type
    ///
    /// - Parameter type: service type
    /// - Returns: DataRetrieving
    func service(ofType type: ServiceType) -> DataRetrieving

}
