//
//  FavoriteNewsController.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//

import UIKit

final class FavoriteNewsController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    //MARK: - Properties
    private let mainView = FavoriteNewsFeedMainView()
    private let network = Network.shared
    private var currentIndex = 0
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        mainView.viewForCollection.reloadData()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
    }
    
    //MARK: - Methods
    private func setupProperties() {
        mainView.viewForCollection.delegate = self
        mainView.viewForCollection.dataSource = self
    }
    
}

extension FavoriteNewsController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsInfoData.favoriteNewsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteNewsFeedCell.identifier, for: indexPath) as! FavoriteNewsFeedCell
        let article = NewsInfoData.favoriteNewsModel[indexPath.row]
        cell.setupProperties(title: article.title, image: article.urlToImage)
        cell.shadowDecorate()
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - create normal coordinator!
        
        let article = NewsInfoData.favoriteNewsModel[indexPath.row]
        let vc = NewsDetailController(model: article)
        present(vc, animated: true)
    }
    
    
    
}

//MARK: - CollectionView Delegate
extension FavoriteNewsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 30
        let height = collectionView.frame.size.height / 4
        return CGSize(width: width, height: height)
    }
}

extension FavoriteNewsController: FavoriteNewsFeedCellProtocol {
    func tapToDelete(cell: FavoriteNewsFeedCell) {
        print(#function)
        if let indexPath = mainView.viewForCollection.indexPath(for: cell) {
            for (index, value) in NewsInfoData.favoriteNewsModel.enumerated() {
                if index == indexPath.row {
                    NewsInfoData.favoriteNewsModel.remove(at: index)
                    mainView.viewForCollection.deleteItems(at: [indexPath])
                }
            }
        }
        
    }
}
