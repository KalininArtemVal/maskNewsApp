//
//  ScreenCoordinator.swift
//  News
//
//  Created by Калинин Артем Валериевич on 23.04.2021.
//

import UIKit

protocol AllTemplatesCoordinatorProtocol: CoordinatorProtocol {
    var assemblyBuilder: AllTemplatesAssemblyBuilderProtocol { get }
    func presentDetailTemplate(templateInfoData: TemplateInfoData)
    func presentFullScreenDetailTemplate(templateInfoData: TemplateInfoData, item: Int)
    func presentEditScreenViewController(templateInfoData: TemplateInfoData, item: Int)
    func presentSubscriptionAfterSettings()
    func presentSubscriptionAfterEdit()
}

final class AllTemplatesCoordinator: AllTemplatesCoordinatorProtocol {
        
    // MARK: - Properties
    var navigationController: UINavigationController
    var assemblyBuilder: AllTemplatesAssemblyBuilderProtocol
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.assemblyBuilder = AllTemplatesAssemblyBuilder()
        startModule()
    }

    // MARK: - Methods
    func startModule() {
        let controller = assemblyBuilder.createAllTemplatesController(coordinator: self,
                                                                      model: AllTemplatesScreenModel.shared)
        navigationController.viewControllers = [controller]
    }
}

extension AllTemplatesCoordinatorProtocol {
    func presentDetailTemplate(templateInfoData: TemplateInfoData) {
        print(#function)
        let controller = assemblyBuilder.createMainCardController(coordinator: self, model: templateInfoData)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func presentFullScreenDetailTemplate(templateInfoData: TemplateInfoData, item: Int) {
        print(#function)
        let controller = assemblyBuilder.createFullScreenCardController(coordinator: self, model: templateInfoData, item: item)
        navigationController.pushViewController(controller, animated: true)
    }
    
}
