//
//  RepoDetailsView.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-07.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit

class RepoDetailsView : UIView {
    
    var userName : UILabel
    //var userImage
    var projectDescription : UILabel
    var projectName : UILabel
    var stars : UILabel
    var forks : UILabel
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override init( frame: CGRect ) {
        
        //todo: use injection here
        self.userName = UILabel()
        self.projectName = UILabel()
        self.stars = UILabel()
        self.forks = UILabel()
        self.projectDescription = UILabel()
        
        super.init(frame: frame)
        
        setUpViewLayout()
        
    }
    
}

extension RepoDetailsView {
    
    func setUpViewLayout() {
        
        self.backgroundColor = UIColor.brown
    
        //specifiy the dimensions and positions for the search bar and table view
        projectName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(projectName);
        
        self.addConstraint(NSLayoutConstraint(item: projectName, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 70 + 10.0));
        
        self.addConstraint(NSLayoutConstraint(item: projectName, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0));
        
        //userName
        userName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(userName);
        
        self.addConstraint(NSLayoutConstraint(item: userName, attribute: .top, relatedBy: .equal, toItem: projectName, attribute: .bottom, multiplier: 1.0, constant: 10.0));
        
        self.addConstraint(NSLayoutConstraint(item: userName, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0));
        
        //userName
        stars.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stars);
        
        self.addConstraint(NSLayoutConstraint(item: stars, attribute: .top, relatedBy: .equal, toItem: userName, attribute: .bottom, multiplier: 1.0, constant: 10.0));
        
        self.addConstraint(NSLayoutConstraint(item: stars, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0));
        
        //forks
        forks.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(forks);
        
        self.addConstraint(NSLayoutConstraint(item: forks, attribute: .top, relatedBy: .equal, toItem: stars, attribute: .bottom, multiplier: 1.0, constant: 10.0));
        
        self.addConstraint(NSLayoutConstraint(item: forks, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0));

        
        //description
        projectDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(projectDescription);
        
        self.addConstraint(NSLayoutConstraint(item: projectDescription, attribute: .top, relatedBy: .equal, toItem: forks, attribute: .bottom, multiplier: 1.0, constant: 10.0));
        
        self.addConstraint(NSLayoutConstraint(item: projectDescription, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0));
        
        self.addConstraint(NSLayoutConstraint(item: projectDescription, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -20.0));
      
        
    }
    
}

