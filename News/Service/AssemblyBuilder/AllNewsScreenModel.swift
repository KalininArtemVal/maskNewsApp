//
//  AllNewsScreenModel.swift
//  News
//
//  Created by Калинин Артем Валериевич on 23.04.2021.
//

import Foundation

protocol AllNewsScreenModelProtocol {
    
    var newsData: [NewsInfoData] { get set }
    var favoriteNewsData: [NewsInfoData] { get set }
}

final class AllTemplatesScreenModel: AllNewsScreenModelProtocol {
    
    // MARK: - Properties
    public static let shared: AllNewsScreenModelProtocol = AllTemplatesScreenModel()
    
    public var currentTemplateTypeInfoData: [NewsInfoData] = []
    
    var newsData: [NewsInfoData]
    
    var favoriteNewsData: [NewsInfoData]
    
}
