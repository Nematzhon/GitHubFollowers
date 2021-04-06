//
//  FollowedListVC.swift
//  GitHubFollowers
//
//  Created by Rizayev Nematzhon on 3/31/21.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
            guard let followers = followers else{
                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: errorMessage!, buttonTitle: "Ok")
                return
            }
           
            print(followers.count)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    


}
