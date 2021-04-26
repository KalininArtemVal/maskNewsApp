////
////  CoreDataService.swift
////  News
////
////  Created by Калинин Артем Валериевич on 26.04.2021.
////
//
import UIKit
import CoreData

class CoreDataService {
    
    // MARK: - Properties
    private init() {}
    static let shared = CoreDataService()
    public let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public var favoriteArticle = [FavoriteArticle]()
    
    // MARK: - Methods
    public func saveData(with articles: [NewsInfoData.Article]) {
        // --- Create Article Object
        let favoriteArticleObject = FavoriteArticle(context: context)
        
        articles.enumerated().forEach { (index, article) in
            favoriteArticleObject.title = article.title
            favoriteArticleObject.descriptionArticle = article.description
            favoriteArticleObject.urlToImage = article.urlToImage
            CoreDataService.shared.favoriteArticle.append(favoriteArticleObject)
        }
        // --- Save Article Object
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    public func fetchFavoriteArticle() {
        // --- Fetch the data
        let fetchRequest: NSFetchRequest<FavoriteArticle> = FavoriteArticle.fetchRequest()

        do {
            CoreDataService.shared.favoriteArticle = try context.fetch(fetchRequest)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
