//
//  AlertMessaging.swift
//  babylon_demo
//
//  Created by Surendra
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

protocol AlertMessaging where Self: UIViewController {
    func showError(_ error: Error, completionHandler: (() -> Void)?)
}
