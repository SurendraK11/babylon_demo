//
//  UserSectionData.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import RxDataSources

/// This model is used to represent table section data in rx data source
struct SectionData {
    var header: String
    var items: [Item]
}

extension SectionData: SectionModelType {
    typealias Item = Post
    
    init(original: SectionData, items: [Item]) {
        self = original
        self.items = items
    }
    
}
