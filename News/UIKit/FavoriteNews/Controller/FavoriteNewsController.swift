//
//  FavoriteNewsController.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//

import UIKit
import CoreData

final class FavoriteNewsController: UIViewController {
    
    //MARK: - Properties
    private let mainView = FavoriteNewsFeedMainView()
    private var favoriteArticle = [FavoriteArticle]()
    private let network = Network.shared
    private let session = Network.shared.session
    private var currentIndex = 0
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataService.shared.fetchFavoriteArticle()
        favoriteArticle = CoreDataService.shared.favoriteArticle
        mainView.viewForCollection.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
    }
    
    //MARK: - Methods
    private func setupProperties() {
        title = "Favorite"
        mainView.viewForCollection.delegate = self
        mainView.viewForCollection.dataSource = self
    }
    
}

// MARK: - Extensions
extension FavoriteNewsController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CoreDataService.shared.favoriteArticle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteNewsFeedCell.identifier, for: indexPath) as! FavoriteNewsFeedCell
        let article = CoreDataService.shared.favoriteArticle[indexPath.row]
        let articleImage = URL(string: article.urlToImage ?? "")
        cell.setupProperties(title: article.title, url: articleImage , session: session)
        cell.shadowDecorate()
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = CoreDataService.shared.favoriteArticle[indexPath.row]
        
        let newArticle = NewsInfoData.Article(title: article.title,
                                              description: article.descriptionArticle,
                                              urlToImage: article.urlToImage)
        let vc = NewsDetailController(model: newArticle)
        navigationController?.present(vc, animated: true)
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
            
            for (index, value) in CoreDataService.shared.favoriteArticle.enumerated() {
                if index == indexPath.row {
                    CoreDataService.shared.context.delete(value)
                    do {
                        try CoreDataService.shared.context.save()
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                    CoreDataService.shared.favoriteArticle.remove(at: index)
                    mainView.viewForCollection.deleteItems(at: [indexPath])
                }
            }
        }
    }
}
