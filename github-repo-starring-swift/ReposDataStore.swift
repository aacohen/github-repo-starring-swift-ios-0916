//
//  ReposDataStore.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    fileprivate init() {}
    
    var repositories:[GithubRepository] = []
    
    func getRepositories(with completion: @escaping () -> ()) {
        GithubAPIClient.getRepositories { (reposArray) in
            self.repositories.removeAll()
            print(3)
            for dictionary in reposArray {
                print(4)
                guard let repoDictionary = dictionary as? [String : Any] else { fatalError("Object in reposArray is of non-dictionary type") }
                let repository = GithubRepository(dictionary: repoDictionary)
                self.repositories.append(repository)
                
            }
            completion()

        }
    }
    
    class func toggleStar(for name:String, completion:(Bool)->()){
        var wasStarred = false
        GithubAPIClient.checkIfRepositoryIsStarred(name) { (isStarred) in
            if isStarred == true{
                GithubAPIClient.unstarRepo(for: name, completion: { (success) in
                    wasStarred = false
                })
                
            }else{
                GithubAPIClient.starRepo(for: name, completion: { (success) in
                    wasStarred = true
                })
                
            }
        }
        completion(wasStarred)
        
    }


}
