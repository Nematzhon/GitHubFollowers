//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Rizayev Nematzhon on 4/8/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placeholder = UIImage(named: "avatar-placeholder")
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(urlString:String){
        
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url){[weak self] data, response, error in
            guard let self = self else {return}
            if error != nil{return}
        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            
            DispatchQueue.main.async {
                self.image =  image
            }
        
        
            
        }
        task.resume()
    }
    
}
