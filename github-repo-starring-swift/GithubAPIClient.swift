//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Alamofire

class GithubAPIClient {
    
    class func getRepositoriesWithCompletion(_ completion: @escaping ([Any]) -> ()) {
        let urlString = "\(Secrets.githubAPIURL)/repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                if let responseArray = responseArray {
                    completion(responseArray)
                }
            }
        }) 
        task.resume()
    }
    
    
    
    class func checkStarred(with name: String, handler: @escaping (Bool) -> Void) {
        
        let baseURL: String = "https://api.github.com"
        
        let searchStarredURL: String = "/user/starred/\(name)"
        
        let tokenURL: String = "?access_token=e0bdcc1a9fad94a758727655cecf53a61f60c083"
        
        let urlString = baseURL + searchStarredURL + tokenURL
        
        guard let url = URL(string: urlString) else { handler(false); return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request) { data, response, error in
         
            
            if let response = response {
                
                print(response)
            } else {
                print("Resposne is nil!, error?: \(error)")
            }
            
            handler(true)
            
            
        }.resume()
        
    }
    
    
//    class func checkIfRepositoryIsStarred(fullName: String, completion: (Bool) -> ()){
//        let urlString = "\(Secrets.githubAPIURL)user/starred/\(fullName)"
//        
//        
//        
//        
//        Alamofire.request(urlString).responseJSON { response in
//        
//            if let response = try? JSONSerialization.jsonObject(with: data, options: []) {
//                if let response = response {
//                    
//                }
//            }
//
//        }
//       // completion
////        if response = "Status: 204 No Content" {
////            return true
////        }
////        else if response = "Status: 404 Not Found" {
////            return false
////        }
//        task.resume()
//    }
}

