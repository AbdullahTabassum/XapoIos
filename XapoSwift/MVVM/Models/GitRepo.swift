//
//  GitRepo.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-06.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import Outlaw

class GitRepo : Deserializable {
    
    var projectName : String
    var stars : Int
    var description : String
    var forks : Int
    var user : GitUser!
    
//    var userName : String
//    var userPicURL : String
 
    init (
        projectName : String = "",
        stars : Int = 0,
        description : String = "",
        forks : Int = 0,
        user : GitUser) {
        
        self.projectName = projectName
        self.stars = stars
        self.description = description
        self.forks = forks
//        self.userName = userName
//        self.userPicURL = userPicURL
        self.user = user
        
    }
    
    required init(object: Extractable) throws {
        
        self.projectName = try object.value(for: "name")
        self.stars = try object.value(for: "stargazers_count")
        self.description = try object.value(for: "description")
        self.forks = try object.value(for: "forks_count")
        
        let userName : String = try object.value(for: "owner.login")
        let avatar : String = try object.value(for: "owner.avatar_url")
        self.user = GitUser(userName: userName, avatarURL: avatar)
        
    }
        
}
