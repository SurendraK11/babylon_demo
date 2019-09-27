//
//  PostDetailViewModel.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import RxRelay

struct PostDetailViewModel {
    var allComments: BehaviorRelay<[Comment]>
    
}
