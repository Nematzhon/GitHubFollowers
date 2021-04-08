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
    
}
