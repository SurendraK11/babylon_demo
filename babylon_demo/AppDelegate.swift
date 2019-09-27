//
//  AppDelegate.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let postListViewModel = PostListViewModel(withDataLoader: DataLoader(withServiceProvider: ServiceProvider(withURLComponentProvider: URLComponentsProvider())))

        window?.rootViewController = UINavigationController(rootViewController: PostsViewController(withViewModel: postListViewModel))
        window?.makeKeyAndVisible()
        
        return true
    }

    
}

