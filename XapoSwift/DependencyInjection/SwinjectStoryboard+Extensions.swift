//
//  SwinjectStoryboard+Extensions.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-06.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import SwinjectStoryboard


extension SwinjectStoryboard {
    @objc class func setup() {
        
        if AppDelegate.dependencyManager == nil {
            AppDelegate.dependencyManager = DependencyManagerImpl(container: defaultContainer)
        }
        
        let dependencyManager: DependencyManager = AppDelegate.dependencyManager
        
        func main() {
            dependencyManager.container.storyboardInitCompleted(ViewController.self) { r, vc in
                
                let coordinator = dependencyManager.makeNavigationManager(with: vc)

                AppDelegate.navigationManager = coordinator
                
                vc.configure( nav: coordinator )
            }
        }
        
        main()
    }
}
