//
//  ModelManager.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-07.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import RxSwift
import Outlaw

typealias GetRepos = ([GitRepo]) -> Void

protocol ModelManager {
    
    func loadRepos( finished: @escaping GetRepos )
}

class ModelManagerImpl : ModelManager{
    
    var bag : DisposeBag = DisposeBag();
    
    var networkLayer : NetworkLayer
    
    init( netLayer : NetworkLayer) {
        
        self.networkLayer = netLayer
        
    }
    
    func loadRepos(finished : @escaping GetRepos) {
        
        print("calling getRepos!!")
        self.networkLayer.buildGetRepoNetworkCall().subscribe(
            
                    onNext : { [weak self] json in
                        self?.parse(reposJson: json, finished: finished)
                    },
                    
                    onError: { error in
                        print("\(error.localizedDescription)")
                    }
        
                ).disposed(by: bag)
    }
    
    //TODO - MOVE the pasrsing stuff to another class
    private func parse(reposJson: [[String: Any]], finished: @escaping GetRepos) {
        
        let repos = convert(reposJSON: reposJson)
        finished(repos)
        
    }
    
    func convert(reposJSON json: [[String: Any]]) -> [GitRepo] {

        let repos = json.flatMap { try? GitRepo(object: $0) }
        
        return repos
    }
    
    
}
