//
//  RepoTableCell.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-06.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit

class RepoTableCell : UITableViewCell {
    
    //child views of the 
    public var projectNameLabel: UILabel!
    public var projectStarsLabel: UILabel!
    public var projectDescriptionLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        projectNameLabel = UILabel()
        projectStarsLabel = UILabel()
        projectDescriptionLabel = UILabel()
        
        self.contentView.addSubview(projectNameLabel)
        self.contentView.addSubview(projectStarsLabel)
        self.contentView.addSubview(projectDescriptionLabel)
        
        applyConstraints()
        applyStyles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension RepoTableCell {
    
    fileprivate func applyConstraints() {
        
        let marginGuide = contentView.layoutMarginsGuide
        
        //project name
        projectNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        projectNameLabel.numberOfLines = 0
        
        projectNameLabel.lineBreakMode = .byWordWrapping
    
        projectNameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 5).isActive = true
        
        projectNameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        
        projectNameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        //stars label
        projectStarsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        projectStarsLabel.numberOfLines = 0
        
        projectStarsLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        
        projectStarsLabel.topAnchor.constraint(equalTo: projectNameLabel.bottomAnchor,  constant: 5).isActive = true
        
        projectStarsLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        //projectDescriptionLabel
        projectDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        projectDescriptionLabel.numberOfLines = 0
        
        projectDescriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        
        projectDescriptionLabel.topAnchor.constraint(equalTo: projectStarsLabel.bottomAnchor, constant: 5).isActive = true
        
        projectDescriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        projectDescriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    
    func applyStyles() {
        
        projectNameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
    
        projectDescriptionLabel.textColor = UIColor.gray
    }
    
}

extension RepoTableCell {
    
    public static var cellID : String {
        return "RepoTableCell"
    }
    
    public static func register(with tableView: UITableView) {
        
        tableView.register(RepoTableCell.self, forCellReuseIdentifier: RepoTableCell.cellID)
        
    }
    
}
