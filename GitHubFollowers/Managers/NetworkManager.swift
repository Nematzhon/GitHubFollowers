//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Rizayev Nematzhon on 4/6/21.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    private init(){}
    
    func getFollowers(for username:String,page: Int, completed: @escaping ([Follower]?,String?) -> Void){
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completed(nil,"This username created an invalid request.Please try again!")
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data,response,error in
            if let _  = error{
                completed(nil,"Unable to complete your request. Please check your internet connection")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil,"Invalid response. Please try again.")
                return
            }
            guard let data = data else{
                completed(nil,"The data received from the server was invalid.Please try again.")
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            }
            catch{
                completed(nil,"The data received from the server was invalid.Please try again.")
            }
            
            
        }
        task.resume()
    }

    
}
