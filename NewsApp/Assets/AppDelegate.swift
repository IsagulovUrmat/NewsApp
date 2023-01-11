//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Isagulov urmat on 16/9/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window = window
        
        window.rootViewController = MainViewController()
        
        window.makeKeyAndVisible()
        
        return true
    }

}

