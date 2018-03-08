//
//  ReposeDetailsViewModel.swift
//  XapoSwift
//
//  Created by Abdullah Tabassum on 2018-03-06.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import RxSwift

class RepoDetailsViewModel {
    
    var selectedRepo : Variable<GitRepo> = Variable<GitRepo>( GitRepo( user: GitUser() ) )
    
    var imageURL : URL
    
    init( selectedRepo : GitRepo ) {
        
        self.selectedRepo.value = selectedRepo
        
        imageURL = URL( string : selectedRepo.user.userAvatarURL)!
    }
    
}
