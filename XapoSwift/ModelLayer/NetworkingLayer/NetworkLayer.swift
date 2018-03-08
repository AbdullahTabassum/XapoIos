//
//  NetworkLayer.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-07.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import enum Result.Result
import RxAlamofire

enum CustomError: Error {
    case forcedError
    case noDataFromServer
}

protocol NetworkLayer {
    func getRepos() -> RxSwift.Observable<(HTTPURLResponse, Any)>
    func getReposDirect(finished: @escaping (Result<[[String: Any]], CustomError>) -> Void)
    func buildGetRepoNetworkCall() -> Observable<[[String: Any]]>
}

class NetworkLayerImpl : NetworkLayer {
    
    func getReposDirect(finished: @escaping (Result<[[String: Any]], CustomError>) -> Void) {
        
        Alamofire.request("https://api.github.com/search/repositories?sort=stars&q=topic:iOS")
                 .responseJSON
            { response in
                
                guard let data = response.data else { return }
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [])

                guard let reposJson = json as? [String: Any] else{
                    finished(.failure(.forcedError))
                    return
                }
                
                guard let items = reposJson["items"] as? [[String: Any]] else {
                    finished(.failure(.forcedError))
                    return
                }
                
                print("these are the number of items \(items.count)")
                
                //print("This is the data \(string)")
                finished(.success(items))
            }
    }
    
    //RxAlamoFire has too many bugs
    func getRepos() -> RxSwift.Observable<(HTTPURLResponse, Any)> {
        return RxAlamofire.requestJSON(.get, "https://api.github.com/search/repositories?sort=stars&q=forks:>30000&order=desc")
    }
    
    func buildGetRepoNetworkCall() -> Observable<[[String:Any]]> {
        return Observable.create { [weak self] observer in
            
            guard let strongSelf = self else { observer.onNext([["":""]]) ; observer.onCompleted() ; return Disposables.create() }
            
            //Execute Request - Do actual work here
            strongSelf.getReposDirect() { result in
                switch result {
                case .success(let info):
                    observer.onNext(info) //push result
                    observer.onCompleted() //finish single unit of work
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                //cleanup dependencies - in this case we have none
            }
        }
    }
}
