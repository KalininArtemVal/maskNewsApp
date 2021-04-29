//
//  AllTemplatesCoordinator.swift
//  News
//
//  Created by Калинин Артем Валериевич on 29.04.2021.
//

import UIKit

protocol AllTemplatesCoordinatorProtocol: Coordinator {
    
    var assemblyBuilder: AllTemplatesAssemblyBuilderProtocol { get }
    
    func presentDetailTemplate(templateInfoData: NewsInfoData.Article)
    
}

final class AllTemplatesCoordinator: AllTemplatesCoordinatorProtocol {
    
    // MARK: - Properties
    var navigationController: UINavigationController?
    var assemblyBuilder: AllTemplatesAssemblyBuilderProtocol
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.assemblyBuilder = AllTemplatesAssemblyBuilder()
        startModule()
    }

    // MARK: - Methods
    func startModule() {
        var vc: UIViewController & Coordinating = AppTabBarController()
        vc.coordinator = self
        
        navigationController?.setViewControllers([vc], animated: false)
    }
}

extension AllTemplatesCoordinator {
    func presentDetailTemplate(templateInfoData: NewsInfoData.Article) {
        let controller = assemblyBuilder.createDetailViewController(coordinator: self, model: templateInfoData)
        navigationController?.pushViewController(controller, animated: true)
    }
}
