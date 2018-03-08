//
//  RepoCollectionView.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-05.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RepoCollectionView : UIView {
        
    let searchBar : UISearchBar!
    
    public var tableView : UITableView!
    
    fileprivate var bag = DisposeBag()
    
    weak var delegate : UITableViewDelegate!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override init( frame: CGRect ) {
        
        //todo: use injection here
        self.searchBar = UISearchBar()
        self.tableView = UITableView()
        
        super.init(frame: frame)
        
        self.setUpViewLayout()
        
        self.setUpTableView()
    }
    
    func configure( del : UITableViewDelegate ) {
        
        self.delegate = del
        self.tableView.delegate = self.delegate
    }
    
    private func setUpViewLayout() {
        
        //specifiy the dimensions and positions for the search bar and table view
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchBar);
        
        self.addConstraint(NSLayoutConstraint(item: searchBar, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: searchBar, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.0, constant: 50.0));
        
        self.addConstraint(NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: searchBar, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0));
        
        //tableView setup
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        self.addSubview(tableView)
        
        self.addConstraint(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: tableView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: -70.0 ));
        
    }
    
    func setUpTableView() {
        
        //register a table view cell
        RepoTableCell.register(with: tableView)
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.delegate = self.delegate
        
    }
}
