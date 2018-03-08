//
//  GitUser.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-07.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import Outlaw

class GitUser : Deserializable {
    
    var userName : String
    var userAvatarURL : String
    
    init (
        userName : String = "",
        avatarURL : String = "" ) {
        self.userName = userName
        self.userAvatarURL = avatarURL
    }
    
    required init(object item: Extractable) throws {
        self.userName = try item.value(for: "login")
        self.userAvatarURL = try item.value(for: "avatar_url")
    }
}
