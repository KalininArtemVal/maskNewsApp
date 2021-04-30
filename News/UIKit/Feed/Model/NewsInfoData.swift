//
//  NewsInfoData.swift
//  News
//
//  Created by Калинин Артем Валериевич on 23.04.2021.
//

protocol NewsInfoDataProtocol {
    
}

final class NewsInfoData: NewsInfoDataProtocol {
    
    struct Articles: Codable {
        let articles: [Article]
    }

    struct Article: Codable {
        let title: String?
        let description: String?
        let urlToImage: String?
    }
    
    static var model = [Article]()
    
    static var favoriteNewsModel = [Article]()
}
