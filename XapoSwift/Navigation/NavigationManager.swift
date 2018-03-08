//
//  NavigationManager.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-06.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationManager {
    
    func next(arguments: Dictionary<String, Any>?)
    
    func moveBack()
    
    var rootViewController: UIViewController { get }
}

enum NavigationState {
    case atWelcomeScreen,
         atGitCollectionScreen,
         atDetailScreen
}

class NavigationManagerImpl: NavigationManager {
    
    var depenendencyManager: DependencyManager
    
    var rootViewController: UIViewController
    
    var currentState: NavigationState = .atWelcomeScreen
    
    init(rootViewController: UIViewController, depManager: DependencyManager) {
        
        self.rootViewController = rootViewController
        self.depenendencyManager = depManager
        
    }
    
    //MARK - NavigationManager imlementation
    func next(arguments: Dictionary<String, Any>?) {
        
        switch currentState {
            case .atWelcomeScreen:
                transitionToReposCollection( barHeight: arguments!["barHeight"] as! CGFloat )
            case .atGitCollectionScreen:
                toRepoDetails( selefctedRepo : arguments!["selectedRepo"] as! GitRepo)
            case .atDetailScreen:
                break
        }
    }
    
    func transitionToReposCollection( barHeight : CGFloat) {
        
        let repoCollectionVC = depenendencyManager.makeGitCollectionViewController(barHeight: barHeight)
        
        rootViewController.navigationController?.pushViewController( repoCollectionVC, animated: true)
        
        currentState = .atGitCollectionScreen
    }
    
    func toRepoDetails( selefctedRepo : GitRepo) {
        print("going to transitoin to repo details")
        let vc = depenendencyManager.makeDetailGitViewController( repo : selefctedRepo )
        
        rootViewController.navigationController?.pushViewController( vc, animated: true)
        
        currentState = .atDetailScreen
    }
    
    func moveBack() {
        
        switch currentState {
            case .atGitCollectionScreen:
                //rootViewController.navigationController?.popViewController(animated: true)
                currentState = .atWelcomeScreen
            case .atDetailScreen:
                //rootViewController.navigationController?.popViewController(animated: true)
                currentState = .atGitCollectionScreen
            case .atWelcomeScreen:
                break;
        }
        
    }
}

