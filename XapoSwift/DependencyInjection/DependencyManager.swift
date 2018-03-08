//
//  DependencyManager.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-06.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

protocol DependencyManager {
    var container: Container { get }
    var navigationManager: NavigationManager! { get }
    
    func makeNavigationManager (with root: UIViewController) -> NavigationManager
    
    func makeGitCollectionViewController ( barHeight: CGFloat ) -> UIViewController
    
    func makeDetailGitViewController( repo : GitRepo ) -> UIViewController
}

class DependencyManagerImpl: DependencyManager {
    
    var navigationManager: NavigationManager!
    var container: Container
    
    init(container: Container) {
        
        Container.loggingFunction = nil
        
        self.container = container
        
        registerDependencies()
        registerPresenters()
        registerViewControllers()
    }
    
    func registerDependencies() {
        
        //navigation manager
        container.register(NavigationManager.self){ (r, rootController: UIViewController) in
            
            return NavigationManagerImpl(rootViewController: rootController, depManager: self)
            
        }.inObjectScope(.container)
        
        //network layer
        container.register(NetworkLayer.self) { r in
            
            return NetworkLayerImpl()
            
        }.inObjectScope(.container)
        
        //model manager
        container.register(ModelManager.self) { r in
            
            let netLayer = r.resolve(NetworkLayer.self)!
            
            return ModelManagerImpl(netLayer: netLayer)
        }.inObjectScope(.container)
        
        //collection view
        container.register(RepoCollectionView.self) { (r, barHeight: CGFloat ) in
            
            let screenSize = UIScreen.main.bounds;
            let screenWidth = screenSize.width;
            let screenHeight = screenSize.height;
            let viewSize = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - barHeight)
            
            return RepoCollectionView( frame: viewSize )
            
        }
        
        //repo details view
        container.register(RepoDetailsView.self) { r in
            
            let screenSize = UIScreen.main.bounds;
            let screenWidth = screenSize.width;
            let screenHeight = screenSize.height;
            let viewSize = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight )
            
            return RepoDetailsView( frame: viewSize )
            
        }
        
    }
    
    func registerPresenters() {
        
        //collection view model
        container.register(RepoCellectionViewModel.self) { (r) in
            
            let modelManager = r.resolve(ModelManager.self)!
            
            return RepoCellectionViewModel(modelManager: modelManager)
        }
        
        //repo details view model
        container.register(RepoDetailsViewModel.self) { (r, repo: GitRepo) in
            
            return RepoDetailsViewModel(selectedRepo: repo)
        }
        
        //
    }
    
    func registerViewControllers() {
        
        //collection view controller
        container.register(ReposCollectionViewController.self) { (r, barHeight: CGFloat ) in
            
            let view = r.resolve(RepoCollectionView.self, argument: barHeight )!
            let viewModel = r.resolve(RepoCellectionViewModel.self)!
            let navManager = self.navigationManager
            
            let vc = ReposCollectionViewController(view : view, viewModel : viewModel, nvManager: navManager! )
            
            view.configure(del: vc)
            
            return vc
        }
        
        //details view controller
        container.register(RepoDetailsViewController.self) { ( r, repo: GitRepo ) in
            
            let view = r.resolve(RepoDetailsView.self)!
            let viewModel = r.resolve(RepoDetailsViewModel.self, argument: repo)!
            let navManager = self.navigationManager!
            
            return RepoDetailsViewController(view: view, vm: viewModel, nm: navManager)
        }
    }
    
    func makeNavigationManager (with root: UIViewController) -> NavigationManager {
        
        navigationManager = container.resolve(NavigationManager.self, argument: root)!
        
        return navigationManager
    }
    
    func makeGitCollectionViewController( barHeight: CGFloat ) -> UIViewController {
        
        return container.resolve( ReposCollectionViewController.self, argument: barHeight )!;
        
    }
    
    func makeDetailGitViewController( repo : GitRepo ) -> UIViewController {
        
        return container.resolve( RepoDetailsViewController.self, argument: repo)!
        
    }
    
}
