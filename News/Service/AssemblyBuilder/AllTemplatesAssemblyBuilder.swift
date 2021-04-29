//
//  AllTemplatesAssemblyBuilder.swift
//  News
//
//  Created by Калинин Артем Валериевич on 29.04.2021.
//

import UIKit

protocol AllTemplatesAssemblyBuilderProtocol {
    
    func createDetailViewController(model: NewsInfoData.Article) -> UIViewController
}

final class AllTemplatesAssemblyBuilder: AllTemplatesAssemblyBuilderProtocol {
    
    func createDetailViewController(model: NewsInfoData.Article) -> UIViewController {
        let controller = NewsDetailController(model: model)
        return controller
    }
    
}
