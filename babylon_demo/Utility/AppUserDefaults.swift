//
//  AppUserDefaults.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct AppUserDefaults {
    
    private let DataDownloadedKey = "DataDownloaded"
    
    var dataDownloaded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: DataDownloadedKey)
        }
    }
    
    func dataDownloadSuccessfully() {
        
        UserDefaults.standard.set(true, forKey: DataDownloadedKey)
        UserDefaults.standard.synchronize()
    }
}
