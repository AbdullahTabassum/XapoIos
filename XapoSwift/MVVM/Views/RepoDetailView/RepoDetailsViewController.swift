//
//  RepoDetailsViewController.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-07.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class RepoDetailsViewController : UIViewController {
    
    var viewModel : RepoDetailsViewModel
    
    var repoView : RepoDetailsView
    
    var navigationManager : NavigationManager
    
    fileprivate var bag = DisposeBag()
    
    init (view : RepoDetailsView, vm : RepoDetailsViewModel, nm: NavigationManager) {
        
        self.repoView = view
        self.viewModel = vm
        self.navigationManager = nm
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        self.view = repoView
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModel.selectedRepo.asObservable().subscribe( onNext : { [weak self] repo in
            
            //update view
            print("DetailsView: this is the selected repo : \(repo.projectName)")
            
            self?.repoView.projectDescription.text = repo.description
            self?.repoView.forks.text = " Forks: " + String(repo.forks)
            self?.repoView.projectName.text = repo.projectName
            self?.repoView.userName.text =  repo.user.userName
            self?.repoView.stars.text = "Stars: " + String(repo.stars)
            
            
        }).disposed(by: bag)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController:parent)
        if parent == nil {
            // The back button was pressed or interactive gesture used
            self.navigationManager.moveBack()
        }
    }
    
}
