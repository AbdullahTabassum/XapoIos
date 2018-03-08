//
//  RepoCollectionViewModel.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-06.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

/**
  *
  * Class will be responsible for exposing view data to the view controller
  *
 **/
class RepoCellectionViewModel {
    
    var gitRepos : Variable<[GitRepo]> = Variable<[GitRepo]>([])
    
    var filteredGitRepos : Variable<[GitRepo]> = Variable<[GitRepo]>([])
    
    var criteria : Variable<String> = Variable<String>("")
    
    var bag : DisposeBag = DisposeBag()
    
    var modelManager : ModelManager
    
    init( modelManager : ModelManager) {
        
        self.modelManager = modelManager
        
        initInternalListeners()
        
    }
    
    fileprivate func initInternalListeners() {
        self.criteria.asObservable().subscribe( { [weak self] value in
            
            self?.filteredGitRepos.value = (self?.gitRepos.value.filter{ repo in
                
                if (value.element == "") { return true }
                
                if repo.projectName.lowercased().range(of: (value.element?.lowercased())! ) != nil {
                    
                        return true
                        
                    } else {
                        
                        return false
                        
                    }
                })!
        } ).disposed(by: bag)
    }
    
    //update the gitRepos
    func updateGitRepos() {
        
        self.modelManager.loadRepos(finished: { [weak self] (repos) in
            
            self?.gitRepos.value = repos
            self?.filteredGitRepos.value = repos
            
        })
        
    }
    
    func filterGitRepos( criteria : String ) {
        
        self.criteria.value = criteria
        
    }
    
}
