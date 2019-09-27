//
//  URLComponentsProviding.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// Responseible to provide URLComponents
protocol URLComponentsProviding {
    
    /// Responseible to provide URLComponents for given serviceType
    ///
    /// - Parameter serviceType: ServiceType
    /// - Returns: URLComponents
    func urlComponents(forServiceType serviceType: ServiceType) -> URLComponents
    
}
