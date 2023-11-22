//
//  AppDelegate.swift
//  FeedArranger
//
//  Created by Tolga Taş on 22.11.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = FeedControllerBuilderImp().buildFeed()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
}

