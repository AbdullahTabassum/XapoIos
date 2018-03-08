//
//  ViewController.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-05.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ViewController : UIViewController {
    var navigationManager: NavigationManager!
    
    func configure(nav: NavigationManager) {
        
        self.navigationManager = nav
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Thread.sleep(forTimeInterval: 2)
        
        let argument: [String: CGFloat] = ["barHeight": (self.navigationController?.navigationBar.frame.height)!]
        
        navigationManager.next(arguments: argument)
    }
}
