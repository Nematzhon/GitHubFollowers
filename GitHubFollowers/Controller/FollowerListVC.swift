//
//  FollowedListVC.swift
//  GitHubFollowers
//
//  Created by Rizayev Nematzhon on 3/31/21.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    var username: String!
    var followers:[Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureGetFollowers()
        configureCollectionView()
        configureDataSource()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureGetFollowers(){
        NetworkManager.shared.getFollowers(for: username, page: 1) {[weak self] (followers, errorMessage) in
            guard let self = self else {return}
            if let followers = followers{
                self.followers = followers
                self.updateData()
            }
            else{
                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: errorMessage!, buttonTitle: "Ok")
                return
            }
        }
    }
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumItemSpacing:CGFloat = 10
        let availableWidth = width-(padding*2)-(minimumItemSpacing*2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth+40)
        
        return flowLayout
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
            
        })
    }
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
    }


}
