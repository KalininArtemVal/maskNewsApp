//
//  CoreDataProperties.swift
//  News
//
//  Created by Калинин Артем Валериевич on 26.04.2021.
//

import Foundation
import CoreData

extension FavoriteArticle {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteArticle> {
        return NSFetchRequest<FavoriteArticle>(entityName: "FavoriteArticle")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var descriptionArticle: String?
    @NSManaged public var urlToImage: String?
}
