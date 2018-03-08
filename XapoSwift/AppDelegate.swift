//
//  AppDelegate.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-04.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var dependencyManager: DependencyManager!
    static var navigationManager: NavigationManager!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
}

