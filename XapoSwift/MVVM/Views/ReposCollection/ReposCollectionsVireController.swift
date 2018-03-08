//
//  ViewController.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-04.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

class ReposCollectionViewController: UIViewController {
    
    var repoView : RepoCollectionView
    
    var navigationManager: NavigationManager
    
    fileprivate var bag = DisposeBag()
    
    var viewModel : RepoCellectionViewModel
    
    init( view : RepoCollectionView, viewModel : RepoCellectionViewModel, nvManager: NavigationManager) {
        
        self.repoView = view
        self.viewModel = viewModel
        self.navigationManager = nvManager
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    func congigure(navManager: NavigationManager) {
        
        self.navigationManager = navManager
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func loadView() {
        
        self.view = self.repoView;
    }
    
    override func viewDidLoad() {
        
        self.viewModel.updateGitRepos()
        
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        repoView.searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe({ [weak self] query in
                
                self?.viewModel.filterGitRepos(criteria: (query.element)!)
                
            }).disposed(by: bag)
        
        //add the listeners and datasource
                viewModel.filteredGitRepos.asObservable().bind(to: repoView.tableView.rx.items(cellIdentifier: RepoTableCell.cellID)) { index, model, cell  in

                    if let cellNew = cell as? RepoTableCell {

                        cellNew.projectNameLabel!.text = model.projectName
                        
                        cellNew.projectStarsLabel!.text = String(model.stars)
                        
                        cellNew.projectDescriptionLabel!.text = model.description

                    } else {

                        print("cant be casted")

                    }

                }.disposed(by: bag)
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController:parent)
        if parent == nil {
            // The back button was pressed or interactive gesture used
            self.navigationManager.moveBack()
        }
    }

}

extension ReposCollectionViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let  selectedRepo = self.viewModel.filteredGitRepos.value[indexPath.row]
        
        //navigate to the next page
        self.navigationManager.next(arguments: ["selectedRepo" : selectedRepo])
    }
    
    
}

