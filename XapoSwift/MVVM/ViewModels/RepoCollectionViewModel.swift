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

struct RepoSection {
    
    var header: String
    
    var items: [Item]
    
}

extension RepoSection: SectionModelType {
    
    typealias Item = GitRepo
    
    init(original: RepoSection, items: [Item]) {
        
        self = original
        
        self.items = items
        
    }
}

class RepoCellectionViewModel {
    
    var gitRepos : Variable<[GitRepo]> = Variable<[GitRepo]>([])
    
    var modelManager : ModelManager
    
    init( modelManager : ModelManager) {
        
        self.modelManager = modelManager
        
    }
    
    //update the gitRepos
    func updateGitRepos() {
        
        self.modelManager.loadRepos(finished: { [weak self] (repos) in
            
            print("These are the received repos from modelmanager")
            print(" \(repos.count)")
            
            self?.gitRepos.value = repos
            
        })
        
    }
    
}
