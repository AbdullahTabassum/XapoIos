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
    
    //let dataSource = Observable<[String]>.just(["first element", "second element", "third element"])
    
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
        
        //add the listeners and datasource
                viewModel.gitRepos.asObservable().bind(to: repoView.tableView.rx.items(cellIdentifier: RepoTableCell.cellID)) { index, model, cell  in

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
    
//    func next(with repo: GitRepo) {
//        let args = ["repo": repo]
//        navigationManager!.next(arguments: args)
//    }

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
        
        let  selectedRepo = self.viewModel.gitRepos.value[indexPath.row]
        
        print("a repo was selectd: \(selectedRepo.projectName)")
        
        //navigate to the next page
        self.navigationManager.next(arguments: ["selectedRepo" : selectedRepo])
    }
    
    
}

