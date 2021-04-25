//
//  FavoriteNewsController.swift
//  News
//
//  Created by Калинин Артем Валериевич on 24.04.2021.
//

import UIKit
import CoreData

final class FavoriteNewsController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    //MARK: - Properties
    private let mainView = FavoriteNewsFeedMainView()
    private var favoriteArticle = [FavoriteArticle]()
    private let network = Network.shared
    private var currentIndex = 0
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCore()
        mainView.viewForCollection.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        saveData(with: NewsInfoData.favoriteNewsModel)
    }
    
    //MARK: - Methods
    private func setupProperties() {
        mainView.viewForCollection.delegate = self
        mainView.viewForCollection.dataSource = self
    }
    
    private func saveData(with articles: [NewsInfoData.Article]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteArticle", in: context) else { return }
        
        let favoriteArticleObject = FavoriteArticle(entity: entity, insertInto: context)
        
        articles.enumerated().forEach { (index, article) in
            favoriteArticleObject.articleTitle = article.title
            favoriteArticleObject.articleDescription = article.description
            favoriteArticleObject.imageUrl = article.urlToImage
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func getCore() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<FavoriteArticle> = FavoriteArticle.fetchRequest()
        
        do {
            favoriteArticle = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}

extension FavoriteNewsController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteArticle.count
//        return NewsInfoData.favoriteNewsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteNewsFeedCell.identifier, for: indexPath) as! FavoriteNewsFeedCell
        
//        let article = NewsInfoData.favoriteNewsModel[indexPath.row]
        let article = favoriteArticle[indexPath.row]
        
        cell.setupProperties(title: article.articleTitle, image: article.imageUrl)
        cell.shadowDecorate()
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - create normal coordinator!
//        let article = NewsInfoData.favoriteNewsModel[indexPath.row]
//        let vc = NewsDetailController(model: article)
//        present(vc, animated: true)
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
            
            for (index, value) in favoriteArticle.enumerated() { //NewsInfoData.favoriteNewsModel
                if index == indexPath.row {
                    favoriteArticle.remove(at: index)
                    mainView.viewForCollection.deleteItems(at: [indexPath])
                }
            }
        }
        
    }
}
